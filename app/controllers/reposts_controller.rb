class RepostsController < ApplicationController
  before_action :set_post

  def create
    @repost = Repost.create(user_id: current_user.id, post_id: @post.id)
  end

  def destroy
    @repost = current_user.reposts.find_by(post_id: @post.id)
    @repost.destroy
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end
end
