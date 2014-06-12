module   ActiveAdmin::ViewsHelper
  def click_to_show(html)
    content_tag(:div, class: 'click-to-show') do
      content_tag(:div, content_tag(:em, "Click to show"), class: 'click-to-show-label') +
      content_tag(:div, html, class: 'click-to-show-content')
    end
  end
end
