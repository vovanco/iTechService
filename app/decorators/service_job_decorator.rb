class ServiceJobDecorator < ApplicationDecorator
  delegate_all
  delegate :service_job_path, :client_path, to: :helpers
  decorates_association :client

  def device

  end

  def presentation
    [device_name, serial_number, imei].join(' / ')
  end

  def presentation_link
    link_to presentation, service_job_path(object)
  end

  def device_name
    (object.item.present? ? object.item.name : object.type_name) || '?'
  end

  def serial_number
    (object.item.present? ? object.item.serial_number : object.serial_number) || '?'
  end

  def imei
    (object.item.present? ? object.item.imei : object.imei) || '?'
  end

  def data_storages
    if object.data_storages.present?
      object.data_storages.map do |storage_num|
        h.content_tag(:span, storage_num, class: 'data_storage_label')
      end.join(' ').html_safe
    else
      '-'
    end
  end

  def creation_date
    I18n.l object.created_at, format: :long_d
  end

  def client_presentation
    client.presentation
  end

  def client_presentation_link
    link_to service_job.client_presentation, client_path(service_job.client)
  end
end