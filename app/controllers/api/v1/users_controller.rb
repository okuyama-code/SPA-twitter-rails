class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show destroy]

  # http://localhost:3000/api/v1/users
  def index
    @users = User.all
    users_with_images = @users.map do |user|
      user.as_json.merge(icon_url: url_for(user.icon), header_url: url_for(user.header))
    end
    render json: { users: users_with_images }
  end

  # http://localhost:3000/api/v1/users/1
  def show
    user_posts = @user.posts.order(created_at: :desc)
    user_posts_with_image = user_posts.map { |post| augment_with_image(post) }

    render json: { user: @user.as_json.merge(icon_url: url_for(@user.icon), header_url: url_for(@user.header)), posts: user_posts_with_image }
  end

  def destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
