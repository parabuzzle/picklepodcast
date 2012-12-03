xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title @title
    xml.description "Bringing you EDM news, music, and more every Sunday afternoon."
    xml.link "http://www.electricpicklepodcast.com"
    xml.language "en-us"
    xml.copyright "copyright #{Time.now.year}"

    for post in @posts
      xml.item do
        xml.title post.title
        xml.description post.pre
        #<enclosure url="http://www.podcastingnews.com/articles/media/Chuck_D_No_Meaning_No_128.mp3" length="640561 " type="audio/mpeg"/>
        xml.enclosure render_rss_enclosure(post)
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link "http://localhost:3000/archive/#{post.url}"
      end
    end
  end
end