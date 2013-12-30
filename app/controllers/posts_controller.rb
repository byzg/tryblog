class PostsController < InheritedResources::Base
  before_filter :prepare_new_post, only: [:index]
  respond_to :js, only: :create
  private
  def prepare_new_post
    @new_post = Post.new
  end
end
