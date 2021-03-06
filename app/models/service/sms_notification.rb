module Service
  class SMSNotification < ActiveRecord::Base
    self.table_name = 'service_sms_notifications'

    belongs_to :sender, class_name: 'User'
    validates_presence_of :phone_number, :message
  end
end
