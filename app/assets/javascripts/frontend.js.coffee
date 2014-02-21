$ ->
  $(document).pjax('a[data-pjax-link]', '#pjax-body')

  $.stratus
    auto_play: false
    download: false
    links: 'http://soundcloud.com/grace-hrabi'
    random: false
    align: 'bottom'
    animate: 'slide'
    buying: true
    color: 'F60' # SVG
    user: true
    stats: false
    volume: 80

  window.onReadyAndPjax()
  $(document).on 'pjax:end', window.onReadyAndPjax


window.onReadyAndPjax = ->
  console.log "called setup"
  $(".fancybox").fancybox
    nextEasing: 'easeInOutQuart'
    prevEasing: 'easeInOutQuart'
    nextSpeed: 150
    prevSpeed: 150
    helpers:
      title:
        type: 'outside'
      overlay:
        speedOut: 0
