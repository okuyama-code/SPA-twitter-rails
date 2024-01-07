# frozen_string_literal: true

module Api
  module V1
    class LikesController < ApplicationController
      before_action :set_post

      #TODO https://github.com/okuyama-code/hc_twitter_clone/blob/notification/app/controllers/likes_controller.rb
      def create
        current_user = User.find(params[:id]);
        # pp "デバック！！！！！！！！！！！！！"
        # pp current_user

        existing_like = current_user.likes.find_by(post_id: @post.id)

        return if existing_like

        @like = current_user.likes.create(post_id: @post.id)
        pp "ライク"
        pp @like
      end

      def destroy
        current_user = User.find(params[:id]);
        @like = current_user.likes.find_by(post_id: @post.id)
        @like.destroy

      end

      private

      def set_post
        @post = Post.find(params[:post_id])
      end
    end
  end
end
