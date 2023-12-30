class Api::V1::SearchController < ApplicationController
   # http://127.0.0.1:3000/api/v1/search/posts
  # http://127.0.0.1:3000/api/v1/search/posts?q=a
  def posts
    @users = User.all
    @posts = Post.where('post_content LIKE ?', "#{params[:q]}%").order(created_at: :desc)

    posts_with_images = @posts.map do |post|
      if post.image.attached?
        post.as_json.merge(image_url: url_for(post.image))
      else
        post.as_json.merge(image_url: nil)
      end
    end

    render json: {
            posts: posts_with_images,
            users: @users
          }
  end
end
