module TradeInDevice::Cell
  class Preview < BaseCell
    self.translation_path = 'trade_in_device'
    private

    include ModelCell
    include ActiveSupport::NumberHelper

    property :id, :number

    def item
      decorated_item.name
    end

    def decorated_item
      @item ||= ItemDecorator.new(model.item)
    end

    def appraised_value
      number_to_currency model.appraised_value
    end

    def received_at
      l model.received_at, format: :date
    end

    def receiver
      link_to model.receiver.presentation, model.receiver
    end

    def replacement_status
      return '-' if model.replacement_status.nil?
      TradeInDevice.human_attribute_name("replacement_status/#{model.replacement_status}")
    end

    def link_to_show
      link_to icon('eye-open'), trade_in_device_path(id), class: 'btn btn-small'
    end

    def link_to_edit
      link_to icon('edit'), edit_trade_in_device_path(id), class: 'btn btn-small'
    end

    def link_to_destroy
      link_to icon('trash'), trade_in_device_path(id), method: 'delete', data: {confirm: t('helpers.links.confirm', default: 'Are you sure?')}, class: 'btn btn-danger btn-small'
    end
  end
end
