class Api::V1::TweetsController < ApplicationController
  def index
    # http://localhost:3000/api/v1/tweets でデータ見れる
    # orderがあるとエラーになる
    # tweets = Tweet.all.order(create_at: :desc)
    tweets = Tweet.all
    users = User.all
    @tweet = Tweet.last
    # @tweet = Tweet.last.to_json(include: [:image])
    image_path = Rails.application.routes.url_helpers.rails_representation_url(@tweet.image.variant({}), only_path: true)

    render json: { tweets: tweets, users: users, image: image_path }, status: 200
  end

  def show
    tweet = Tweet.find_by(id: params[:id])
    render json: { tweet: tweet }
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

end
