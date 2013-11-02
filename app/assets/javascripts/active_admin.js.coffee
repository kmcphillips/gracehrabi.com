#= require active_admin/base
#= require admin_images

$ ->
  $("#image_sortable").sortable update: ->
    $.ajax
      url: "/admin2/images/sort"
      type: "post"
      data: $("#image_sortable").sortable("serialize")
      error: ->
        alert "There was an error sorting images. Contact administrator."
  $("#image_sortable").disableSelection()

