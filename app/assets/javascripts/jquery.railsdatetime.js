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
      var datetimepicker = this.datetimepicker(this.element, this.settings);

      datetimepicker.selectYear.hide();
      datetimepicker.selectMonth.hide();
      datetimepicker.selectDay.hide();

      // Format the hours
      if(this.settings.ampm){
        var selected = parseInt(datetimepicker.selectHour.val(), 10);

        datetimepicker.selectHour.children().remove();

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

          datetimepicker.selectHour.append(option);
        }
      }

      // Format the minutes
      datetimepicker.selectMinute.find("option").each(function() {
        var value = $(this).val();

        // TODO: this.options.minutes
        if (value !== "00" && value !== "15" && value !== "30" && value !== "45") {
          $(this).remove();
        }
      });

      // Fire callback
      if(this.settings.afterInit)
        this.settings.afterInit.call(this.element);

      // TODO: Assert jQuery-ui is present

      // Setup the date picker text input
      datetimepicker.datepicker.datepicker({
        changeMonth: true,
        dateFormat: "yy/mm/dd",
        onClose: function(text) {
          var tokens = text.split("/");

          // TODO: Assert length 3

          datetimepicker.selectYear.val(tokens[0].replace(/^[0]/g, ""));
          datetimepicker.selectMonth.val(tokens[1].replace(/^[0]/g, ""));
          datetimepicker.selectDay.val(tokens[2].replace(/^[0]/g, ""));
        }
      });
    },
    datetimepicker: function(element, settings) {
      var picker = {
        container: $(settings.containerHtml),
        datepicker: $(settings.inputHtml),
        selects: $(element).find('select')
      };

      // TODO: Assert number of selects

      picker.selectYear = $(picker.selects[0])
      picker.selectMonth = $(picker.selects[1])
      picker.selectDay = $(picker.selects[2])
      picker.selectHour = $(picker.selects[3])
      picker.selectMinute = $(picker.selects[4])

      picker.datepicker.attr('value', "" + picker.selectYear.val() + "/" + picker.selectMonth.val() + "/" + picker.selectDay.val());

      $(element).append(picker.container);
      picker.container.prepend(picker.datepicker);

      picker.selectYear.hide();
      picker.selectMonth.hide();
      picker.selectDay.hide();

      picker.selectHour.detach().appendTo(picker.container);
      picker.selectMinute.detach().appendTo(picker.container);

      return picker;
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
