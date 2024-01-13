# frozen_string_literal: true

module Api
  module V1
    class LikesController < ApplicationController
      before_action :set_post

      def create
        current_user = User.find(params[:id])

        existing_like = current_user.likes.find_by(post_id: @post.id)

        return if existing_like

        @like = current_user.likes.create(post_id: @post.id)

        @post.create_notification_like!(current_user)

        render json: { like: @like }
      end

      def destroy
        current_user = User.find(params[:id])
        @like = current_user.likes.find_by(post_id: @post.id)
        @like.destroy

        render json: { like: @like }
      end

      private

      def set_post
        @post = Post.find(params[:post_id])
      end
    end
  end
end
