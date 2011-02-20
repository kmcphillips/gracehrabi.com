$(document).ready(function(){
    $("a[rel^='inlinePrettyPhoto']").prettyPhoto({
        animation_speed: 'fast',
        slideshow: false,
        opacity: 0.60,
        show_title: true,
        allow_resize: false,
        default_width: 500,
        default_height: 344,
        counter_separator_label: ' of ',
        theme: 'dark_square',
        hideflash: false,
        keyboard_shortcuts: true,
        overlay_gallery: false
    });
});