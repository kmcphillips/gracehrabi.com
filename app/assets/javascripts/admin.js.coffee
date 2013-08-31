$(document).ready ->
  $(".datepicker").datepicker dateFormat: "yy-mm-dd"
  $(".datetimepicker").datetimepicker
    ampm: true
    stepMinute: 15

  $(".preview-link").click ->
    preview_link()

  convert_datetime_select("#starts_at_container") if $("#starts_at_container").size() > 0

window.stripe_table = (table) ->
  $(table).find("tr").each (index, element) ->
    $(element).removeClass "odd even"
    if index % 2 is 0
      $(element).addClass "even"
    else
      $(element).addClass "odd"

window.convert_datetime_select = (id) ->
  year = 0
  month = 0
  day = 0
  $(id).find("select").each (index, select) ->
    switch index
      when 0 # year
        year = $(select).val()
        $(select).hide()
      when 1 # month
        month = $(select).val()
        $(select).hide()
      when 2 # day
        day = $(select).val()
        $(select).hide()
      when 3 # hour
        selected = $(select).val()
        $(select).children().remove()
        i = 0
        while i <= 23
          if i is 0
            text = "AM 12"
          else if i < 12
            text = "AM " + i
          else if i is 12
            text = "PM 12"
          else
            text = "PM " + (i - 12)
          $(select).append "<option value='" + i + "' " + ((if selected is i then "selected='selected'" else "")) + ">" + text + "</option>"
          i++
      when 4 # minute
        $(select).find("option").each ->
          $(this).remove()  if $(this).val() isnt "00" and $(this).val() isnt "15" and $(this).val() isnt "30" and $(this).val() isnt "45"


  $(id).prepend "<input type='text' size='10' class='datetime_picker' value='" + year + "/" + month + "/" + day + "' />"
  $(id).find("input[type=text]").datepicker
    changeMonth: true
    changeYear: true
    dateFormat: "yy/mm/dd"
    onClose: (text) ->
      tokens = text.split("/")
      i = 0
      while i <= 2
        $($(id).find("select")[i]).val tokens[i].replace(/^[0]/g, "")
        i++

window.submit_manitoba_music = (event_id, form_id) ->
  $.post "/admin/events/" + event_id + "/submit_manitoba_music", {}, (data) ->
    alert "success!"
    $("#" + form_id).submit()

window.preview_link = ->
  if !$("#link_url").val().match(/^http(s)?:\/\/.+/)
    alert("URL must begin with 'http://' or 'https://'")
  else
    window.open $("#link_url").val()

  false