# frozen_string_literal: true

module Api
  module V1
    class RepostsController < ApplicationController
      before_action :set_post

      def create
        existing_repost = Repost.find_by(user_id: params[:id], post_id: @post.id)

        return if existing_repost

        @repost = Repost.create(user_id: params[:id], post_id: @post.id)

        render json: { repost: @repost}
      end

      def destroy
        @post = Post.find(params[:post_id])
        @repost = Repost.find_by(user_id: params[:id], post_id: @post.id)

        return unless @repost

        @repost.destroy
        render json: { repost: @repost}
      end

      private

      def set_post
        @post = Post.find(params[:post_id])
      end
    end
  end
end
