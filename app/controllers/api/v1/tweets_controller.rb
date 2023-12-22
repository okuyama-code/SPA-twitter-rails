class Api::V1::TweetsController < ApplicationController
  before_action :set_tweet, only: %i[show destroy]

  #  http://localhost:3000/api/v1/tweets でデータ見れる
  def index
    @tweets = Tweet.all.order(created_at: :desc)
    users = User.all

    tweets_with_images = @tweets.map do |tweet|
      if tweet.image.attached?
        tweet.as_json.merge(image_url: url_for(tweet.image))
      else
        tweet.as_json.merge(image_url: nil)
      end
    end
    render json: { tweets: tweets_with_images, users: users }, status: 200

  end

  # http://localhost:3000/api/v1/tweets/50
  def show
    if @tweet.image.attached?
      render json: @tweet.as_json.merge(image_url: url_for(@tweet.image))
    else
      render json: @tweet.as_json.merge(image_url: nil)
    end
  end

  # Reactからcurrent_user.idを送るパターン
  # def create
  #   tweet = Tweet.new(tweet_params)

  #   if tweet.save!
  #     render json: { tweet: tweet }, status: :ok
  #   else
  #     render json: { error_message: tweet.errors.full_messages }, status: :bad
  #   end
  # end

  # current_userを使う方
  def create
    tweet = current_user.tweets.build(tweet_params)
    # 画像投稿できるようにする記述

    if tweet.valid?
       # imageが送信された場合。以下の部分で画像データを保存し、tweetのデータに添付する
      if params[:image][:name] != ""
        blob =  ActiveStorage::Blob.create_and_upload!(
          io: StringIO.new(decode(params[:image][:data]) + "\n"),
          filename: params[:image][:name]
        )
        tweet.image.attach(blob)
      end
    end

    if tweet.save!
      render json: { tweet: tweet }, status: :ok
    else
      render json: { error_message: tweet.errors.full_messages }, status: 422
    end
  end

  def create_images

  end

  private
  def tweet_params
    params.require(:tweet).permit(:tweet_content, :user_id, :image)
  end

  def decode(string)
    Base64.decode64(string.split(',').last)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

end
