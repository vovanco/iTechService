class BaseReport
  attr_reader :kind, :department_id

  def self.call(attributes = {})
    new(attributes).call
  end

  def name
    @name ||= self.class.name.underscore.gsub('_report', '')
  end
  alias_method :base_name, :name

  def initialize(attributes = {})
    attributes.each do |name, value|
      setter_name = "#{name}="
      send setter_name, value if respond_to? setter_name
    end
  end

  def call
  end

  def result
    @result ||= {}
  end

  def only_day?
    false
  end

  def start_date=(value)
    @start_date = (value.is_a?(String) ? value.to_time(:local) : value).strftime('%d.%m.%Y')
  end

  def start_date
    @start_date ||= Time.current.strftime('%d.%m.%Y')
  end

  def end_date=(value)
    @end_date = (value.is_a?(String) ? value.to_time(:local) : value).strftime('%d.%m.%Y')
  end

  def end_date
    @end_date ||= start_date
  end

  def period
    start_date.to_time(:local).beginning_of_day..end_date.to_time(:local).end_of_day
  end

  def department_id=(value)
    @department_id = value.presence
  end

  def department
    return @department if defined? @department

    @department = department_id ? Department.find(department_id) : nil
  end

  def model_name
    ActiveModel::Name.new self, nil, 'report'
  end

  def persisted?
    false
  end

  def to_model
    self
  end
end