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
    pp "デバック！！！！！！！！！！！！！"
    pp params
    tweet = Tweet.new(tweet_params)

    if tweet.save!
      render json: { tweet: tweet }, status: :ok
    else
      render json: { error_message: tweet.errors.full_messages }, status: :bad
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:tweet_content, :user_id, :image)
  end

end
