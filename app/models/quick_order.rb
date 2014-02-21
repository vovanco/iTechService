class QuickOrder < ActiveRecord::Base

  scope :id_asc, order('id asc')
  scope :created_desc, order('created_at desc')
  scope :month_ago, where(created_at: 1.month.ago..DateTime.current)

  belongs_to :user
  has_and_belongs_to_many :quick_tasks
  attr_accessible :client_name, :comment, :contact_phone, :number, :is_done, :quick_task_ids
  before_create :set_number

  after_initialize do
    self.user_id ||= User.current.try(:id)
    self.is_done ||= false
  end

  private

  def set_number
    last_number = QuickOrder.created_desc.first.try(:number)
    self.number = (last_number.present? and last_number < 9999) ? last_number.next : 1
  end

end
