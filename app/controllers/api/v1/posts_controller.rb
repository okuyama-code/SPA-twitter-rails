# frozen_string_literal: true

module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, only: %i[show destroy]
      before_action :authenticate_user!, only: %i[create]

      #  http://localhost:3000/api/v1/posts?page=3 でデータ見れる
      def index
        posts_per_page = 5
        @posts = Post.order(created_at: :desc)
        posts_with_images = paginate_posts(@posts, posts_per_page)
        total_posts_count = Post.count

        render json: {
          posts: posts_with_images,
          total_count: total_posts_count,
          per_page: posts_per_page
        }
      end

      # http://localhost:3000/api/v1/posts/50
      def show
        if @post.image.attached?
          render json: @post.as_json.merge(image_url: url_for(@post.image))
        else
          render json: @post.as_json.merge(image_url: nil)
        end
      end

      def create
        post = current_user.posts.build(post_params)
        if post.save!
          render json: { post: }, status: :ok
        else
          render json: { error_message: post.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def attach_images
        return unless params[:image][:name] != ''

        blob = ActiveStorage::Blob.create_and_upload!(
          io: StringIO.new("#{decode(params[:image][:data])}\n"),
          filename: params[:image][:name]
        )
        post = Post.find(params[:id])
        post.image.attach(blob)
        render json: { post: }
      end

      def destroy
        @post.destroy
        render json: { post: @post }
      end

      # http://localhost:3000/api/v1/posts/87/comments
      def post_comment
        @post = Post.find(params[:post_id])
        post_comments = @post.comments.order(created_at: :desc)

        render json: { post_comments: }
      end

      private

      def post_params
        params.require(:post).permit(:post_content)
      end

      def decode(string)
        Base64.decode64(string.split(',').last)
      end

      def set_post
        @post = Post.find(params[:id])
      end
    end
  end
end
