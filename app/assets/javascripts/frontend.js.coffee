$ ->
  $(document).pjax('a[data-pjax-link]', '#pjax-body', {timeout: 5000})
  $(document).on 'pjax:end', window.onReadyAndPjax
  window.onReadyAndPjax()

  $(document).on 'pjax:send', ->
    NProgress.start()

  $(document).on 'pjax:complete', ->
    NProgress.done()

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
