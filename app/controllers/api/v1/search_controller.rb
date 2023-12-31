class Api::V1::SearchController < ApplicationController
   # http://localhost:3000/api/v1/search/
  # http://localhost:3000/api/v1/search/?q=a
  def index
    posts_per_page = 4
    @posts = Post.where('post_content LIKE ?', "%#{params[:q]}%").order(created_at: :desc)

    posts_with_images = paginate_posts(@posts, posts_per_page)
    total_posts_count = @posts.count

    render json: {
      posts: posts_with_images,
      total_count: total_posts_count,
      per_page: posts_per_page
    }
  end
end
