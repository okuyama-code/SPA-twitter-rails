# frozen_string_literal: true

module Api
  module V1
    class ProfileController < ApplicationController
      # 海外youtubeのupdateとeditをマネする
      def update
        @user = User.find(params[:id])
        if @user.update(profile_params)
          render json: { message: 'ユーザー情報の編集に成功しました' }, status: :ok
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def profile_params
        params.require(:user).permit(:name, :date_of_birth, :self_introduction, :location, :website, :icon, :header)
      end
    end
  end
end
