class PostsController < ApplicationController
  before_filter :prepare_new_post, only: [:index]

  private
  def prepare_new_post
    @new_post = Post.new
  end
end
