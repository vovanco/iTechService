class API < Grape::API
  prefix 'api'
  format :json
  default_format :json
  REALM = 'ise_api'

  helpers do
    def logger
      API.logger
    end

    def auth_token_from_headers
      if (env['HTTP_AUTHORIZATION'] || headers['Authorization']).to_s[/^Token (.*)/]
        values = Hash[$1.split(',').map do |value|
          value.strip!                      # remove any spaces between commas and values
          key, value = value.split(/\=\"?/) # split key=value pairs
          value.chomp!('"')                 # chomp trailing " in value
          value.gsub!(/\\\"/, '"')          # unescape remaining quotes
          [key, value]
        end]
        #[values.delete("token"), values.with_indifferent_access]
        values.delete("token")
      end
    end

    def current_user
      if (token = auth_token_from_headers).present?
        @current_user ||= User.where(is_fired: [false, nil], authentication_token: token).first
        User.current = @current_user
      end
    end

    def authenticate!
      error!({error: 'Unauthorized'}, 401) unless current_user
    end

    def authorize!(action, object)
      Pundit.policy!(current_user, object).public_send("#{action}?")
    end
  end

  rescue_from Pundit::NotAuthorizedError do |e|
    Rack::Response.new({error: e.message}.to_json, 403).finish
  end

  mount TokenApi
  mount UserApi
  mount BarcodeApi
  mount DeviceApi
  mount ProductApi
  mount QuickOrderApi
  mount RepairApi
  mount OrderApi
end