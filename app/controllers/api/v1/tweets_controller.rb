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

end
