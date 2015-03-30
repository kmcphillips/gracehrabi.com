$ ->
  $(document).pjax('a[data-pjax-link]', '#pjax-body', {timeout: 5000})
  $(document).on 'pjax:end', window.onReadyAndPjax
  window.onReadyAndPjax()

  $(document).on 'pjax:send', ->
    NProgress.start()

  $(document).on 'pjax:complete', ->
    NProgress.done()

  setTimeout(showCBCSearchlight, 1000)

window.onReadyAndPjax = ->
  $(".fancybox").fancybox
    nextEasing: 'easeInOutQuart'
    prevEasing: 'easeInOutQuart'
    nextSpeed: 150
    prevSpeed: 150
    helpers:
      title:
        type: 'inside'
      overlay:
        speedOut: 0
        css:
          background: 'rgba(238,238,238,0.25)'

  $("div.header a").click -> $(@).blur()

window.showCBCSearchlight = ->
  cookieName = 'cbc_searchlight_2015_round1'
  unless $.cookie(cookieName)
    $.cookie(cookieName, 'shown', {expires: 1})
    $.fancybox.open($("#searchlight_modal"))

window.dismissCBCSearchlight = ->
  $.fancybox.close($("#searchlight_modal"))
