class Api::V1::TweetsController < ApplicationController
  before_action :set_tweet, only: %i[show destroy]

  #TODO 消すかも
  include Pagination

  #  http://localhost:3000/api/v1/tweets でデータ見れる
  # def index
  #   @tweets = Tweet.all.order(created_at: :desc)
  #   # pageメソッドはページ番号、perメソッドは1ページあたりの表示数を指定。
  #   tweets_per_page = 2
  #   # @tweets = Tweet.page(page_number).per(per_page).order(created_at: :desc)
  #   users = User.all

  #   tweet_with_images = paginate_tweets(@tweets, tweets_per_page)

  #   total_tweets_count = Tweet.count

  #   # Num of pages = ceil(total_posts_count / posts_per_page) => ceil(25 / 24) = ceil(1.04) = 2
  #   render json: {
  #     tweets: tweet_with_images,
  #     total_count: total_tweets_count,
  #     per_page: tweets_per_page,
  #     users: users }

  # end

  def index
    users = User.all
    @tweets = Tweet.page(params[:page]).per(params[:per])
    # @tweets = Tweet.all
    # tweets_with_images = @tweets.map do |tweet|
    #   if tweet.image.attached?
    #     tweet.as_json.merge(image_url: url_for(tweet.image))
    #   else
    #     tweet.as_json.merge(image_url: nil)
    #   end
    # end

    @pagination = pagination(@tweets)
    render json: {
      tweets: @tweets,
      pagenation: @pagination,
      users: users
    }

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
