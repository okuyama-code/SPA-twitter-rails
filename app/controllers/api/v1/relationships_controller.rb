class Api::V1::RelationshipsController < ApplicationController
  # before_action :authenticate_user!

  # TODO https://github.com/okuyama-code/hc_twitter_clone/blob/notification/app/controllers/relationships_controller.rb

  # /api/v1/users/:user_id/follow
  def create
    current_user = User.find(params[:id]);
    existing_follow = Relationship.find_by(following_id: params[:id], follower_id: params[:user_id])
    return if existing_follow

    following = current_user.relationships.build(follower_id: params[:user_id])
    following.save
    current_user.create_notification_follow!(current_user, params[:user_id])
  end

  # /api/v1/users/:user_id/unfollow
  def destroy
    current_user = User.find(params[:id]);
    following = current_user.relationships.find_by(follower_id: params[:user_id])
    following.destroy
  end
end
