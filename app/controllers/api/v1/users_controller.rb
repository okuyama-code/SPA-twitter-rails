# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: %i[show update destroy]

      # http://localhost:3000/api/v1/users
      def index
        @users = User.all
        users_with_images = @users.map do |user|
          user.as_json.merge(icon_url: url_for(user.icon), header_url: url_for(user.header))
        end
        render json: { users: users_with_images }
      end

      # http://localhost:3000/api/v1/users/1
      def show
        render json: { user: @user.as_json.merge(icon_url: url_for(@user.icon), header_url: url_for(@user.header)) }
      end

      def update; end

      def destroy; end

      private

      def set_user
        @user = User.find(params[:id])
      end
    end
  end
end
