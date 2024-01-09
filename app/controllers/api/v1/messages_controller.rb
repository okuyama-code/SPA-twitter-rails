# frozen_string_literal: true

module Api
  module V1
    class MessagesController < ApplicationController
      # before_action :authenticate_user!

      # http://localhost:3000/api/v1/groups/:group_id/messages
      def index
        group = Group.find(params[:group_id])
        # group = Group.find(1)
        messages = group.messages

        render json: {messages: messages}
      end

      def create
        group = Group.find(params[:group_id])
        message = group.messages.build(message_params)
        message.user_id = current_user.id
        if message.save!
          render json: {message: message}
        else
          render json: { error: "saveできませんでした"}
        end
      end

      private

      def message_params
        params.require(:message).permit(:body)
      end
    end
  end
end
