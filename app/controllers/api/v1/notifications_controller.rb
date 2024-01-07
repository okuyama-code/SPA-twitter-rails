# frozen_string_literal: true

module Api
  module V1
    class NotificationsController < ApplicationController
      # TODO
      # http://localhost:3000/api/v1/notifications
      def index
        @notifications = Notification.all
        @notifications.where(checked: false).each do |notification|
          notification.update(checked: true)
        end

        render json: { notifications: @notifications }
      end
    end
  end
end
