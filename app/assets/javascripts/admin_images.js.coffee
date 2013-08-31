$(document).ready ->
  $("#previous_image").dialog
    autoOpen: false
    buttons:
      Cancel: ->
        $(this).dialog "close"

    modal: true
    height: 500
    width: 700
    title: "Select a previous image"

  $(".image input.image-file-field").change ->
    if $(".image input.image-file-field").val() and $(".image input.image-file-field").val() isnt ""
      resetClear()
      resetPrevious()

  $(".select-previous-image-button").click ->
    $('#previous_image').dialog('open')
    false

  $(".previous-image-link").click ->
    selectImage $(this).data('image-id'), $(this).data('image-src')
    false

  $(".clear-image").click ->
    clearImage()
    false

window.clearImage = ->
  $("#clear_image_field").val "true"
  resetUpload()
  resetPrevious()

window.selectImage = (id, src) ->
  $("#previous_image").dialog "close"
  $("#current_image").attr "src", src
  $("#current_image").show()
  $("#previous_image_id").val id
  resetUpload()
  resetClear()

window.resetClear = ->
  $("#clear_image_field").val ""

window.resetUpload = ->
  $(".image input.image-file-field").val ""

window.resetPrevious = ->
  $("#current_image").hide()
  $("#previous_image_id").val ""
