#= require webshims/polyfiller
#= require active_admin/base
#= require admin_images
#= require active_admin_datetime_picker
#= require facebook

$ ->
  setTimeout ->
    console.log("Setting up webshims.polyfill")
    $.webshims.setOptions('basePath', '/assets/webshims/shims/')
    $.webshims.polyfill()
  , 2000

  $("#image_sortable").sortable update: ->
    $.ajax
      url: "/admin/images/sort"
      type: "post"
      data: $("#image_sortable").sortable("serialize")
      error: ->
        alert "There was an error sorting images. Contact administrator."
  $("#image_sortable").disableSelection()

  $(".click-to-show-label").on 'click', ->
    $(this).hide()
    $(this).closest('.click-to-show').find('.click-to-show-content').show()
