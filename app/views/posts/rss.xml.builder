xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title PAGE_TITLE
    xml.description PAGE_SUB_TITLE
    xml.link "http://gracehrabi.com"

    for item in @items
      if item.is_a?(Post)
        xml.item do
          xml.title item.title
          xml.description simple_format(item.body)
          xml.pubDate item.created_at.to_s(:rfc822)
          xml.link "http://gracehrabi.com/blog/#{item.permalink}"
        end
      elsif item.is_a?(Event)
        xml.item do
          xml.title item.title
          xml.description simple_format(item.description)
          xml.pubDate item.created_at.to_s(:rfc822)
          xml.link "http://gracehrabi.com/events/#{item.id}"
        end
      end
    end
  end
end

