class Api::V1::SignInController < ApplicationController
  def index
    if current_user
      # render json: current_user
      render json: { is_login: true, current_user_data: current_user }
    else
      render json: { is_login: false, message: "ユーザーは存在しません"}
    end
  end
end

