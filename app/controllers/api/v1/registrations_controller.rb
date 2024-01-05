# frozen_string_literal: true

module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      private

      def sign_up_params
        params.permit(:email, :password, :password_confirmation, :name, :username)
      end
    end
  end
end
