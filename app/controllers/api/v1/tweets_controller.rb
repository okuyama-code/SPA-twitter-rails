class Api::V1::TweetsController < ApplicationController
  before_action :set_tweet, only: %i[show destroy]



  #  http://localhost:3000/api/v1/tweets でデータ見れる
  def index
    users = User.all
    @posts = Post.order(created_at: :desc)

    posts_with_images = @posts.map do |post|
      if post.image.attached?
        post.as_json.merge(image_url: url_for(post.image))
      else
        post.as_json.merge(image_url: nil)
      end
    end

    render json: { posts_with_images }
  end

  # http://localhost:3000/api/v1/tweets/50
  def show
    if @tweet.image.attached?
      render json: @tweet.as_json.merge(image_url: url_for(@tweet.image))
    else
      render json: @tweet.as_json.merge(image_url: nil)
    end
  end


  def create
    tweet = current_user.tweets.build(tweet_params)
    if tweet.save!
      render json: { tweet: tweet }, status: :ok
    else
      render json: { error_message: tweet.errors.full_messages }, status: 422
    end
  end

  def attach_images
    # 直前に作成されたレコードにattachする形で進める。
    # imageが送信された場合。以下の部分で画像データを保存し、tweetのデータに添付する
    if params[:image][:name] != ""
      pp "デバック！！！！！！！！！！！！！"
      pp params
      blob =  ActiveStorage::Blob.create_and_upload!(
        io: StringIO.new(decode(params[:image][:data]) + "\n"),
        filename: params[:image][:name]
      )
      tweet = Tweet.last
      tweet.image.attach(blob)

      # if tweet.image.attached?
      #   render json: { tweet: tweet }, status: :ok
      # else
    end
  end

  private
  def tweet_params
    # params.require(:tweet).permit(:tweet_content, :user_id, :image)
    params.require(:tweet).permit(:tweet_content)
  end

  def decode(string)
    Base64.decode64(string.split(',').last)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end



end
