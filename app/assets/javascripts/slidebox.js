$(function() {

  window.slidebox = {
    containerElement: $('#slidebox'),
    closeElement: $('#slidebox .close'),
    triggerElement: null,
    cookieName: 'slidebox_dismissed',
    cookieExpiresDays: 14,
    showDelaty: 15000,
    init: function(){
      _this = this;

      this.closeElement.bind('click', function(){
        _this.dismiss();
      });

      if(!$.cookie(this.cookieName))
      {
        if(this.showDelaty){
          setTimeout(function(){
            _this.show();
          }, this.showDelaty);
        }

        if(this.triggerElement && this.triggerElement.length > 0){
          console.log("scrolling");
          $(window).scroll(function(){
            distanceTop = _this.triggerElement.offset().top - $(window).height();

            if($(window).scrollTop() > distanceTop)
              _this.hide();
            else
              _this.show();
          });
        }
      }
    },
    hide: function(){
      width = this.containerElement.css('width');
      width = (parseInt(width.replace("px")) + 30) * -1;

      this.containerElement.animate({right: width + 'px'}, 300);
      return this;
    },
    show: function(){
      this.containerElement.animate({right: '0px'}, 300);
      return this;
    },
    dismiss: function(){
      this.hide();
      $.cookie(this.cookieName, 'dismissed', {expires: this.cookieExpiresDays});
      return this;
    },
    resetCookie: function(){
      $.removeCookie(this.cookieName);
      return this;
    }
  };

  // window.slidebox.cookieName = "test";
  // window.slidebox.showDelaty = 1000;
  window.slidebox.init()

});
