# frozen_string_literal: true

module Api
  module V1
    class LikesController < ApplicationController
      before_action :set_post

      def create
        existing_like = Like.find_by(user_id: params[:id], post_id: @post.id)

        return if existing_like

        @like = Like.create(user_id: params[:id], post_id: @post.id)
        render json: { like: @like }
      end

      def destroy
        @post = Post.find(params[:post_id])
        @like = Like.find_by(user_id: params[:id], post_id: @post.id)

        return unless @like

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
