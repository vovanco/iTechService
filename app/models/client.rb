class Client < ActiveRecord::Base
  include ApplicationHelper
  
  has_many :devices, inverse_of: :client
  attr_accessible :name, :phone_number
  
  validates :name, :phone_number, presence: true
  
  def name_phone
    "#{self.name} | #{ActionController::Base.helpers.number_to_phone self.phone_number, area_code: true}"
  end
end
