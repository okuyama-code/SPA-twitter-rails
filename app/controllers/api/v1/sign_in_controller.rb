# frozen_string_literal: true

module Api
  module V1
    class SignInController < ApplicationController
      def index
        if current_user
          user = User.find(current_user.id)

          render json: { is_login: true,
                         current_user_data: user.as_json.merge(icon_url: url_for(user.icon),
                                                               header_url: url_for(user.header)) }
        else
          render json: { is_login: false, message: 'ユーザーは存在しません' }
        end
      end
    end
  end
end
