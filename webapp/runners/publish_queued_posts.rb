# This script publishes a queued post
# (meant to be ran on cron every sunday @ 3:00p)

require 'json'

def post_to_social(endpoint,params)
  uri = URI.parse(endpoint)
 
  post_params = { 
    :title => params[:title],
    :message => params[:message],
    :social_token => SOCIAL_TOKEN
  }
 
  # Convert the parameters into JSON and set the content type as application/json
  req = Net::HTTP::Post.new(uri.path)
  req.body = JSON.generate(post_params)
  req["Content-Type"] = "application/json"
  
  http = Net::HTTP.new(uri.host, uri.port)
  response = http.start {|htt| htt.request(req)}
end

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
  p = Post.find(:all, :conditions=>{:draft=>false}, :order=>:pubdate).last
  code = post_to_social("http://mikeheymans.com/facebook/social_share", {:title=>p.title,:message=>p.pre})
  logger.info("[publish_queued_posts] posted to the social share app with return code: #{code}")
  logger.info("[publish_queued_posts] finished publishing posts... exiting")
  logger.flush
else
  logger.info("[publish_queued_posts] no queued posts... exiting")
  logger.flush
end