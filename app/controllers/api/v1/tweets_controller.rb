class Api::V1::TweetsController < ApplicationController
  def index
    # orderがないとエラーになる
    # tweets = Tweet.all.order(create_at: :desc)
    tweets = Tweet.all
    render json: { tweets: tweets}
  end

  def show
    tweet = Tweet.find_by(id: params[:id])
    render json: { tweet: tweet }
  end

  def create
    post = current_user.tweets.build(post_params)
    if post.save
      render json: { post: post }, status: :ok
    else
      render json: { error_message: post.errors.full_messages}, status: :bad
    end
  end

  private
  def post_params
    params.require(:tweet).permit(:tweet_content, :image)
  end

end
