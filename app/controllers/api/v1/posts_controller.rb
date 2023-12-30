class Api::V1::PostsController < ApplicationController
  before_action :set_post, only: %i[show destroy]

  #  http://localhost:3000/api/v1/posts でデータ見れる
  def index
    @posts = Post.order(created_at: :desc)

    posts_with_images = @posts.map do |post|
      if post.image.attached?
        post.as_json.merge(image_url: url_for(post.image))
      else
        post.as_json.merge(image_url: nil)
      end
    end

    render json: { posts: posts_with_images }
  end

  # http://localhost:3000/api/v1/posts/50
  def show
    if @post.image.attached?
      render json: @post.as_json.merge(image_url: url_for(@post.image))
    else
      render json: @post.as_json.merge(image_url: nil)
    end
  end

  def create
    post = current_user.posts.build(post_params)
    if post.save!
      render json: { post: post }, status: :ok
    else
      render json: { error_message: post.errors.full_messages }, status: 422
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
      post = Post.last
      post.image.attach(blob)
    end
  end

  # http://localhost:3000/api/v1/user_all
  def get_users
    @users = User.all
    render json: { users: @users }
  end

  private
  def post_params
    params.require(:post).permit(:post_content)
  end

  def decode(string)
    Base64.decode64(string.split(',').last)
  end

  def set_post
    @post = Post.find(params[:id])
  end


end
