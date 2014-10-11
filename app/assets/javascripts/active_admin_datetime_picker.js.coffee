$ ->
  $("li.datetime_select").each ->
    year = 0
    month = 0
    day = 0

    container = $("<p class='inline-hints'></p>")
    $(this).append(container)

    $(this).find("ol.fragments-group li.fragment").each (index, node) ->
      select = $(this).find('select')

      switch index
        when 0 # year
          year = select.val()
          select.hide()

        when 1 # month
          month = select.val()
          select.hide()

        when 2 # day
          day = select.val()
          select.hide()

        when 3 # hour
          selected = parseInt(select.val())
          select.children().remove()

          for i in [0..23]
            if i is 0
              text = "AM 12"
            else if i < 12
              text = "AM " + i
            else if i is 12
              text = "PM 12"
            else
              text = "PM " + (i - 12)

            option = "<option value='#{ i }' #{ if selected == i then " selected='selected'" else "" }>#{ text }</option>"
            select.append(option)

          select.detach().appendTo(container)

        when 4 # minute
          select.find("option").each ->
            value = $(this).val()
            $(this).remove() if value isnt "00" and value isnt "15" and value isnt "30" and value isnt "45"

          select.detach().appendTo(container)

    $(this).find("ol.fragments-group").hide()

    container.prepend("<input type='text' size='10' class='datetime_picker' value='#{ year }/#{  month }/#{ day }' />")
    container.find("input[type=text]").datepicker
      changeMonth: true
      dateFormat: "yy/mm/dd"
      onClose: (text) =>
        parent = $(this).closest("li.datetime_select")

        for token, index in text.split("/")
          if index < 3
            select = $(parent.find("select")[index])
            value = token.replace(/^[0]/g, "")

            select.val(value)
