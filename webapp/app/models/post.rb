class Post < ActiveRecord::Base
  attr_accessible :title, :body, :url, :mp3, :pre, :length
end
