window.GlucoseReadingController = () ->
  grc = this
  
  grc.init = () ->
    $('#glucose_reading_reading_at').datetimepicker({dateFormat: "yy-mm-dd", timeFormat: 'hh:mm', showAnim: "blind"})
    return grc
  
  grc.init()
