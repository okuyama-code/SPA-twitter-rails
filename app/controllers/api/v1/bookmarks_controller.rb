# frozen_string_literal: true

module Api
  module V1
    class BookmarksController < ApplicationController
      before_action :set_post

      def index
        Bookmark.all
      end

      def create
        current_user = User.find(params[:id])

        current_user.bookmarks.create(post_id: @post.id)

        render json: { bookmark: @bookmark }
      end

      def destroy
        current_user = User.find(params[:id])

        @bookmark = current_user.bookmarks.find_by(post_id: @post.id)
        @bookmark.destroy

        render json: { bookmark: @bookmark }
      end

      private

      def set_post
        @post = Post.find(params[:post_id])
      end
    end
  end
end
