window.GlobalSetups = () ->
  gs = this
  gs.init = () ->
    # fade flash notices
    $("#container .info").hide('fade',{easing: 'easeInQuint'},2000)
    $("#container .warning").hide('fade',{easing: 'easeInQuint'},2000)
    $("#container .error").hide('fade',{easing: 'easeInQuint'},2000)
    $("#container .notice").hide('fade',{easing: 'easeInQuint'},2000)
    # set time zone
    today = new Date()
    offset = today.getTimezoneOffset()
    $.cookie('time_zone', offset, { path: '/'})
    # Make errors nice pop-ups
    $('#error_explanation').dialog
      modal: true,
      buttons:
        Ok: () ->
          $(this).dialog('close')
    return gs
  
  gs.init()

$ ->
  window.global_setups = window.GlobalSetups()
  window.glucose_reading_controller = window.GlucoseReadingController()