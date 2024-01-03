class Api::V1::ProfileController < ApplicationController
  # 海外youtubeのupdateとeditをマネする
  def update
    @user = User.find(params[:id]);
    if @user.update(profile_params)
      render json: { message: 'ユーザー情報の編集に成功しました' }, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    # TODO usernameを消すかどうか、画像が通るかどうか
    params.require(:user).permit(:name, :email, :date_of_birth, :self_introduction, :location, :website, :username, :icon, :header)
  end
end
