# frozen_string_literal: true

module Api
  module V1
    class LikesController < ApplicationController
      before_action :set_post

      #TODO https://github.com/okuyama-code/hc_twitter_clone/blob/notification/app/controllers/likes_controller.rb
      def create
        existing_like = Like.find_by(user_id: params[:id], post_id: @post.id)

        return if existing_like

        @like = Like.create(user_id: params[:id], post_id: @post.id)
      end

      def destroy
        @post = Post.find(params[:post_id])
        @like = Like.find_by(user_id: params[:id], post_id: @post.id)

        return unless @like

        @like.destroy
      end

      private

      def set_post
        @post = Post.find(params[:post_id])
      end
    end
  end
end
