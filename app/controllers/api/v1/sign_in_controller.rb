# frozen_string_literal: true

module Api
  module V1
    class SignInController < ApplicationController
      def index
        if current_user
          render json: { is_login: true, current_user_data: current_user }
          Rails.logger.debug 'デバック！！！！！！！！！！！！！'
          Rails.logger.debug current_user
        else
          render json: { is_login: false, message: 'ユーザーは存在しません' }
        end
      end
    end
  end
end
