# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApplicationController
      def create
        @comment = Comment.new(comment_params)
        @comment.user_id = current_user.id

        if @comment.save
          @comment.post.create_notification_comment!(current_user, @comment.id)
          render json: { comment: @comment }
        else
          render json: { message: 'コメントの作成に失敗しました。' }
        end
      end

      def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        render json: { comment: @comment }
      end

      private

      def comment_params
        params.require(:comment).permit(:comment_content, :post_id)
      end
    end
  end
end
