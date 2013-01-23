xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0", "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd" do
  xml.channel do
    xml.title @title
    xml.image "http://electricpicklepodcast.com/assets/itunesimage-small.jpg"
    xml.description "Every Sunday afternoon, Mike Heymans and Eesa bring you the latest in the EDM scene. We dive in to what's new, and what's up and coming and we aren't afraid to tell you our opinion, good or bad."
    xml.link "http://www.electricpicklepodcast.com"
    xml.language "en-us"
    xml.copyright "copyright #{Time.now.year}"
    xml.itunes(:subtitle, "Your everything EDM podcast. Including news, music, and unfiltered opinions every Sunday afternoon.")
    xml.itunes(:author, "Mike Heymans and Eesa")
    xml.itunes(:summary, "Every Sunday afternoon, Mike Heymans and Eesa bring you the latest in the EDM scene. We dive in to what's new, and what's up and coming and we aren't afraid to tell you our opinion, good or bad.")
    xml.itunes(:owner, "mikeheymansmusic@gmail.com")
    xml.itunes(:image, "http://electricpicklepodcast.com/assets/itunesimage.png")
    xml.itunes(:explicit, "yes")
    xml.itunes(:category, "Music")
    keywords="EDM, Dance, Music, News, Funny, Opinion, House, Electro, Dubstep, Trap, Trance, Drumstep, DnB, Eesa, Heymans"
    xml.itunes(:keywords, keywords)
    for post in @posts
      xml.item do
        xml.title post.title
        xml.itunes(:author, "Mike Heymans and Eesa")
        #xml.itunes(:subtitle, post.pre)
        xml.description post.pre
        xml.itunes(:summary, post.pre)
        if post.duration.nil?
          post.duration = "1:00:00"
        end
        xml.itunes(:duration, post.duration)
        xml.itunes(:keywords, keywords)
        xml.itunes(:image, "http://electricpicklepodcast.com/assets/itunesimage.png")
        xml.enclosure render_rss_enclosure(post)
        xml.pubDate post.pubdate.to_s(:rfc822)
        xml.guid "epp_id-#{post.id}"
        xml.link "http://electricpicklepodcast.com/archive/#{post.url}"
      end
    end
  end
end