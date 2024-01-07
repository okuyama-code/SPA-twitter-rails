# frozen_string_literal: true

module Api
  module V1
    class RelationshipsController < ApplicationController
      # before_action :authenticate_user!

      # https://github.com/okuyama-code/hc_twitter_clone/blob/notification/app/controllers/relationships_controller.rb

      # /api/v1/users/:user_id/follow
      def create
        existing_follow = Relationship.find_by(following_id: params[:id], follower_id: params[:user_id])
        return if existing_follow

        # followingにcurrentUser.idを、follower_idに相手ユーザーのshowページのURLパラメーターのuser_idを
        following = Relationship.new(following_id: params[:id], follower_id: params[:user_id])
        following.save
      end

      # /api/v1/users/:user_id/unfollow
      def destroy
        following = Relationship.find_by(following_id: params[:id], follower_id: params[:user_id])
        following.destroy
      end
    end
  end
end
