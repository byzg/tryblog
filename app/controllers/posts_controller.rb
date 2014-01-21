class PostsController < InheritedResources::Base
  before_filter :prepare_index, only: :index
  actions :index, :create, :update
  respond_to :js, only: [:create, :update]
  private
  def prepare_index
    @post = Post.new
  end
end
