# This script publishes a queued post
# (meant to be ran on cron every sunday @ 3:00p)

logger = Rails.logger
logger.info("[publish_queued_posts] starting...")

@posts = Post.find(:all, :conditions=>{:draft=>true, :queued=>true})

unless @posts.length == 0
  logger.info("[publish_queued_posts] found #{@posts.length} queued posts")
  @posts.each do |post|
    post.draft = false
    post.pubdate = Time.now
    post.queued = false
    if post.save
      logger.info("[publish_queued_posts] published #{post.title}")
    else
      logger.error("[publish_queued_posts] error publishing #{post.title}")
    end
  end

  logger.info("[publish_queued_posts] finished publishing posts... exiting")
  logger.flush
else
  logger.info("[publish_queued_posts] no queued posts... exiting")
  logger.flush
end