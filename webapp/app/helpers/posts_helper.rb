module PostsHelper
  def render_rss_enclosure(feed_item)
      file = feed_item.mp3
      {:url => file, :length => feed_item.length, :type => "audio/mpeg"}
    end
end
