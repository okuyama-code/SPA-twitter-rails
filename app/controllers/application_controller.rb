# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken

  skip_before_action :verify_authenticity_token

  private

  # augment 増強する　付け足す
  # TODO 拡張repostカウント　動作確認
  def augment_with_image(post)
    if post.image.attached?
      post.as_json.merge(image_url: url_for(post.image), post_repost_count: post.reposts.count, post_like_count: post.likes.count)
    else
      post.as_json.merge(image_url: nil, post_repost_count: post.reposts.count, post_like_count: post.likes.count)
    end
  end

  def paginate_posts(posts, posts_per_page)
    paginated_posts = posts.page(params[:page]).per(posts_per_page)
    paginated_posts.map { |post| augment_with_image(post) }
  end
end
