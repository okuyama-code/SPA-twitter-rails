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
      if params[:tweet][:image]
        blob =  ActiveStorage::Blob.create_after_upload!(
          io: StringIO.new(decode(params[:tweet][:image][:data]) + "\n"),
          filename: params[:tweet][:image][:filename]
        )
        pp "デバック！！！！！！！！！！！！！"
        pp blob
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
