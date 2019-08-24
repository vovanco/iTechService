class ImportMailer < ApplicationMailer

  def sales_import_log(import_logs)
    @import_logs = import_logs
    mail to: 'kvn047@gmail.com', subject: "Sales import log [#{l(Time.current, format: :long_d)}]"
  end

  def product_import_log(import_log, time, type)
    @import_log = import_log
    mail to: 'kvn047@gmail.com', subject: t('mail.product_import_log.subject', type: type.to_s.humanize, time: l(time, format: :long))
  end

end