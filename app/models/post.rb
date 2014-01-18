class Post < ActiveRecord::Base
  attr_accessible :content, :subject
  validates_presence_of :content
end
