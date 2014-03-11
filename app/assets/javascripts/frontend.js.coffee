$ ->
  $(document).pjax('a[data-pjax-link]', '#pjax-body')
  $(document).on 'pjax:end', window.onReadyAndPjax
  window.onReadyAndPjax()


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

  $(".calendar-event-icon").qtip
    position:
      my: 'top center'
    style:
      classes: 'qtip-light qtip-shadow'
    hide:
      event: 'unfocus click mouseleave'

  $("div.header a").click -> $(@).blur()
