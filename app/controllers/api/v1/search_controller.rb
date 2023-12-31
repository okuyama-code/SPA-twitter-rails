class Api::V1::SearchController < ApplicationController
   # http://localhost:3000/api/v1/search/
  # http://localhost:3000/api/v1/search/?q=a
  def index
    @posts = Post.where('post_content LIKE ?', "%#{params[:q]}%").order(created_at: :desc)


    posts_with_images = @posts.map do |post|
      if post.image.attached?
        post.as_json.merge(image_url: url_for(post.image))
      else
        post.as_json.merge(image_url: nil)
      end
    end

    render json: posts_with_images
  end
end
