class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  
  before_filter :logged_in, :except => [:index, :view, :feed]
  
  def index
    @title = "Archive"
    @posts = Post.all(:conditions => { :draft => false }).reverse

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @posts }
    end
  end
  
  def feed
    # this will be the name of the feed displayed on the feed reader
    @title = "The Electric Pickle Podcast"

    # the news items
    @posts = Post.all(:conditions => { :draft => false},:order=>"updated_at desc" )

    # this will be our Feed's update timestamp
    #@updated = @news_items.first.updated_at unless @news_items.empty?

    respond_to do |format|
      format.html { redirect_to format.rss}
      format.rss { render :layout => false } #index.rss.builder
    end
  end
  
  
  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @title = @post.title
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @post }
    end
  end
  
  def view
    @post = Post.find_by_url(params[:url])
    @title = @post.title
    respond_to do |format|
      format.html
      format.json { render :json => @post}
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @title = "Create New Post"
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    @title = "edit - #{@post.title}"
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @title = "Create New Post"
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, :notice => 'Post was successfully created.' }
        format.json { render :json => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    @title = "EDIT"
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, :notice => 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def make_live
    @post = Post.find(params[:id])
    @post.draft = false
    @post.save
    flash[:error] = "published and live!"
    redirect_to "/"
    return
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    @title = "Kill Post"

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
