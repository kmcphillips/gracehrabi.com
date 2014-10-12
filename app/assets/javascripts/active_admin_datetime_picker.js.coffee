$ ->
  $("li.datetime_select").railsdatetime
    containerHtml: "<p class='inline-hints'></p>"
    inputHtml: "<input type='text' size='10' class='datetime_picker'>"
    afterInit: ->
      $(this).find("ol.fragments-group").hide()
