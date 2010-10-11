xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title PAGE_TITLE
    xml.description PAGE_SUB_TITLE
    xml.link "http://gracehrabi.com"

    for post in @posts
      xml.item do
        xml.title post.title
        xml.description simple_format(post.body)
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link "http://gracehrabi.com/blog/#{post.permalink}"
      end
    end
  end
end

