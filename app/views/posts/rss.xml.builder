xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title Settings.page_title
    xml.description Settings.page_sub_title
    xml.link "http://gracehrabi.com"

    for item in @items
      if item.is_a?(Post)
        xml.item do
          xml.title item.title
          xml.description auto_link(simple_format(item.body))
          xml.pubDate item.created_at.to_s(:rfc822)
          xml.link "http://gracehrabi.com/news/#{item.permalink}"
        end
      elsif item.is_a?(Event)
        xml.item do
          xml.title item.title
          xml.description auto_link(simple_format(item.starts_at.to_s(:event_with_time) + "\n\n" + item.description))
          xml.pubDate item.created_at.to_s(:rfc822)
          xml.link "http://gracehrabi.com/events/#{item.id}"
        end
      end
    end
  end
end

