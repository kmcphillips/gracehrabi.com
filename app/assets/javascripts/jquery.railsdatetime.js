// Based on https://github.com/jquery-boilerplate/jquery-boilerplate

;(function ($, window, document, undefined){
  var pluginName = "railsdatetime";
  var defaults = {
    ampm: true,
    minutes: 'quarterhour',
    containerHtml: "<div></div>",
    inputHtml: "<input type='text'>",
    afterInit: null
  };

  function Plugin(element, options){
    this.element = element;
    this.settings = $.extend( {}, defaults, options );
    this._defaults = defaults;
    this._name = pluginName;
    this.init();
  }

  $.extend(Plugin.prototype, {
    init: function(){
      var year = 0,
      month = 0,
      day = 0;

      // Setup the element which will hold the new select
      var container = $(this.settings.containerHtml);
      $(this.element).append(container);

      // Pull out the five dropdowns
      // TODO: Assert
      var selects = $(this.element).find('select');

      selects.each(function(index, node){
        var select = $(node);

        switch(index){
          // Year
          case 0:
            year = select.val();
            select.hide();
            break;

          // Month
          case 1:
            month = select.val();
            select.hide();
            break;

          // Day
          case 2:
            day = select.val();
            select.hide();
            break;

          // Hour
          case 3:
            var selected = parseInt(select.val());

            select.children().remove();

            for (var i = 0; i <= 23; i++){
              var text;

              if (i === 0) {
                text = "AM 12";
              } else if (i < 12) {
                text = "AM " + i;
              } else if (i === 12) {
                text = "PM 12";
              } else {
                text = "PM " + (i - 12);
              }
              var option = "<option value='" + i + "' " + (selected === i ? " selected='selected'" : "") + ">" + text + "</option>";
              select.append(option);
            }

            select.detach().appendTo(container);
            break;

          // Minute
          case 4:
            select.find("option").each(function() {
              var value = $(this).val();

              // TODO: this.options.minutes
              if (value !== "00" && value !== "15" && value !== "30" && value !== "45") {
                $(this).remove();
              }
            });

            select.detach().appendTo(container);
            break;
        }
      });

      // Fire callback
      if(this.settings.afterInit)
        this.settings.afterInit.call(this.element);

      // Add the datepicker
      var datepicker = $(this.settings.inputHtml);
      datepicker.attr('value', "" + year + "/" + month + "/" + day);

      container.prepend(datepicker);

      // Assumes jQuery-ui is present
      // TODO: Assert
      datepicker.datepicker({
        changeMonth: true,
        dateFormat: "yy/mm/dd",
        onClose: function(text) {
          var tokens = text.split("/");

          for(var index = 0; index < tokens.length && index < 3; index++){
            var value = tokens[index].replace(/^[0]/g, "");
            var select = selects[index];

            $(select).val(value);
          }
        }
      });
    }
  });

  $.fn[pluginName] = function(options){
    this.each(function() {
      if (!$.data( this, "plugin_" + pluginName)){
        $.data( this, "plugin_" + pluginName, new Plugin(this, options));
      }
    });
    return this;
  };
})(jQuery, window, document);
