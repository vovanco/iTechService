jQuery ->

  $service_job_form = $('form.service_job_form')

  $('.service_job_comment_tooltip').tooltip()

  $('.service_job_progress').tooltip
    placement: 'left'
    html: true

  if $service_job_form.length > 0

    $(document).on 'change', '.device_task_task', () ->
      task_id = $(this).val()
      $row = $(this).parents('.device_task')
      task_cost = $row.find('.device_task_cost')
      is_change_location = $row.is(':first-child')
      $.getJSON "/tasks/#{task_id}.json", (data)->
        task_cost.val data.cost
        if is_change_location
          $('#service_job_location_id').val(data.location_id)
          $('#location_value').text(data.location_name)
        if data['is_repair?']
          document.getElementById('service_job_notify_client').checked = true

#    $(document).on 'change', '.device_task:first-child .device_task_task', ->
#      task_id = $(this).val()
#      unless task_id is ''
#        $.getJSON "/tasks/#{task_id}.json", (data)->
#          $field = $('#service_job_location_id')
#          if $field.find("[value='#{data.location_id}']").length == 0
#            $field.append "<option value='#{data.location_id}'>#{data.location_name}</option>"
#          $field.val(data.location_id)

    $('a', '#locations_list').click (event) ->
      $('#location_value').text $(this).text()
      $('#service_job_location_id').val $(this).attr('location_id')
      event.preventDefault()

    $('#service_job_security_code_none').click (event)->
      $('#service_job_security_code').val '-'
      event.preventDefault()

    $('#service_job_contact_phone_none').click (event)->
      $('#service_job_contact_phone').val '-'
      event.preventDefault()

    $('#service_job_contact_phone_copy').click (event)->
      client_phone = $('#client_search').val().split('/')[1].match(/[0-9]/g).join('')
      $('#service_job_contact_phone').val client_phone
      event.preventDefault()

  $('#service_job_serial_number').keydown (event)->
    $this = $(this)
    if (event.keyCode in [65..90]) and (event.metaKey is false) and (event.ctrlKey is false) and (event.altKey is false)
      $this.val($this.val()+String.fromCharCode(event.keyCode))
      event.preventDefault()

#  $('#service_job_imei').blur ()->
#    $.getJSON '/service_jobs/check_imei?imei_q='+$(this).val(), (data)->
#      if data.present
#        $('#service_job_imei').parents('.control-group').addClass 'warning'
#        if $('#service_job_imei').siblings('.help-inline').length
#          $('#service_job_imei').siblings('.help-inline').html data.msg
#        else
#          $('#service_job_imei').parents('.controls').append "<span class='help-inline'>"+data.msg+"</span>"
#      else
#        $('#service_job_imei').parents('.control-group').removeClass 'warning'
#        $('#service_job_imei').siblings('.help-inline').remove()

  $('#service_job_imei_search, #service_job_serial_number_search').click ()->
    $this = $(this)
    val = $this.prev('input').val()
    if val isnt ''
      $.getJSON '/imported_sales?search='+val, (res)->
        info_tag = "<span class='help-inline imported_sales_info'>"
        if res.length > 0
          for r in res
            d = new Date(r.sold_at)
            info_tag += '[' + d.toLocaleDateString() + ': ' + r.quantity + '] '
        else
          info_tag += res.message
        info_tag += "</span>"
        $this.parent().siblings('.imported_sales_info').remove()
        $this.parent().after info_tag
      $.getJSON '/items?saleinfo=1&q=' + val, (res)->
        $this.parent().siblings('.sales_info').remove()
        if res.id
          if res.sale_info
            info_s = res.sale_info
          else
            info_s = '-'
        else
          info_s = res.message
        $this.parent().after "<span class='help-inline sales_info'>#{info_s}</span>"

  $('#new_service_job_popup').mouseleave ->
    setTimeout (->
      $('#new_service_job_popup').fadeOut()
    ), 1000

  $('#check_imei_link').click ->
    imei = $(this).parent().find('input').val()
    this.setAttribute('href', "http://iunlocker.net/check_imei.php?imei=#{imei}")

$(document).on 'click', '.returning_device_tooltip', ->
  $(this).tooltip()
  $(this).tooltip('toggle')

PrivatePub.subscribe '/service_jobs/new', (data, channel)->
  if data.service_jobs.location_id == $('#profile_link').data('location')
    $('#new_service_job_popup').fadeIn()

PrivatePub.subscribe '/service_jobs/returning_alert', (data, channel)->
  $.getScript '/announcements/'+data.announcement_id
