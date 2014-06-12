#= require active_admin/base
#= require admin_images
#= require facebook

$ ->
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
