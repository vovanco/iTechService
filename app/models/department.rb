class Department < ActiveRecord::Base

  ROLES = {
    0 => 'main',
    1 => 'branch',
    2 => 'store'
  }

  default_scope order('departments.id asc')
  scope :branches, where(role: 1)

  has_many :users, dependent: :nullify
  has_many :stores, dependent: :nullify
  has_many :cash_drawers, dependent: :nullify
  has_many :settings, dependent: :destroy
  has_many :devices, inverse_of: :department
  # cattr_accessor :current

  attr_accessible :name, :role, :code, :url, :city, :address, :contact_phone, :schedule
  validates_presence_of :name, :role, :code
  validates_presence_of :city, :address, :contact_phone, :schedule, :url, unless: :is_store?
  validate :only_one_main

  def self.find(*args, &block)
    begin
      super
    rescue ActiveRecord::RecordNotFound
      self.find_by_uid(args[0]) if self.respond_to?(:find_by_uid)
    end
  end


  def role_s
    ROLES[role]
  end

  def is_main?
    role == 0
  end

  def is_branch?
    role == 1
  end

  def is_store?
    role == 2
  end

  def self.current
    Department.find_by_code(ENV['DEPARTMENT_CODE'] || 'vl') || Department.first
  end

  def default_cash_drawer
    cash_drawers.first_or_create name: 'Cash drawer 1'
  end

  def current_cash_shift
    default_cash_drawer.current_shift
  end

  private

  def only_one_main
    errors.add :role, :main_exists if role == 0 and Department.where('id <> ? AND role = ?', self.id, 0).count > 1
    false
  end

end
