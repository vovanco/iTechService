class Setting < ActiveRecord::Base

  DEFAULT_SETTINGS = {
      ticket_prefix: 'string',
      address: 'string',
      contact_phone: 'string',
      schedule: 'string',
      duck_plan: 'string',
      duck_plan_url: 'string',
      address_for_check: 'string',
      data_storage_qty: 'integer',
      meda_menu_database: 'string'
  }

  VALUE_TYPES = %w[boolean integer string text]

  default_scope {order('settings.id asc')}
  scope :for_department, ->(department) { where(department_id: department.is_a?(Department) ? department.id : department) }

  belongs_to :department
  delegate :name, to: :department, prefix: true, allow_nil: true

  attr_accessible :name, :presentation, :value, :value_type, :department_id
  validates :name, :value_type, presence: true
  validates_uniqueness_of :name, scope: :department_id

  class << self
    def ticket_prefix(department=nil)
      (setting = Setting.for_department(department).find_by_name('ticket_prefix')).present? ? setting.value : '25'
    end

    def get_value(name, department=nil)
      (setting = Setting.for_department(department).find_by_name(name.to_s) || Setting.where(department_id: nil, name: name.to_s)).present? ? setting.value : ''
    end

    def duck_plan(department)
      Setting.for_department(department).find_by_name('duck_plan').try :value
    end

    def duck_plan_url(department)
      Setting.for_department(department).find_by_name('duck_plan_url').try :value
    end

    def data_storage_qty
      Setting.for_department(Department.current).find_by_name('data_storage_qty')&.value&.to_i
    end

    def meda_menu_database
      Setting.for_department(Department.current).find_by(name: 'meda_menu_database')&.value
    end
  end
end
