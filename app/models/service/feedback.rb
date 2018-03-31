module Service
  class Feedback < ActiveRecord::Base
    self.table_name = 'service_feedbacks'

    MAX_DELAY_HOURS = [72, 120, 168]

    scope :inactive, -> { where scheduled_on: nil }
    scope :actual, -> { where('scheduled_on <= ?', Time.current) }
    scope :old_first, -> { order 'created_at ASC' }

    belongs_to :service_job
    validates_presence_of :service_job_id

    delegate :ticket_number, :client_surname, :device_short_name, to: :service_job, allow_nil: true

    def self.max_delay_hours_for_job(job)
      feedbacks_count = where(service_job_id: job.id).count
      MAX_DELAY_HOURS[feedbacks_count] || MAX_DELAY_HOURS[-1]
    end

    def presentation
      [ticket_number, client_surname, device_short_name].join(' / ')
    end

    def device_name
      service_job&.item&.name
    end

    def device_presentation
      service_job&.presentation
    end

    def add_log(new_log)
      self.log = [log.presence, new_log].compact.join('<br/>')
    end
  end
end
