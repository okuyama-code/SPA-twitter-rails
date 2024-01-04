class Api::V1::CommentsController < ApplicationController
  def create
    pp "デバック！！！！！！！！！！！！！"
    pp current_user
    @comment = Comment.build(comment_params)
    @comment.user = current_user

    if @comment.save
      render json: {comment: @comment}
    else
      render json : { message: "コメントの作成に失敗しました。"}
    end
  end

  # 修正必要かも
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content, :post_id)
    # params.require(:comment).permit(:comment_content, :comment_img)
    # formにてpost_idパラメータを送信して、コメントへpost_idを格納するようにする必要がある。
  end
end
