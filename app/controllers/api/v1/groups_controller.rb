# frozen_string_literal: true

module Api
  module V1
    class GroupsController < ApplicationController
      # http://localhost:3000/api/v1/groups
      def index
        current_entries = current_user.entries
        my_group_id = []
        current_entries.each do |entry|
          # エントリーから取得したルームIDを my_room_id 配列に追加しています。
          my_group_id << entry.group.id
        end
        # 自分のroom_idと同じでuser_idが自分ではないentryを取得
        another_entries = Entry.where(group_id: my_group_id).where.not(user_id: current_user.id)


        render json: {current_entries: current_entries, another_entries: another_entries}
      end

      def show
        pp "デバック！！！！！！！！！！！！！"
        pp current_user

        @group = Group.find(params[:id])
        @entries = @group.entries
        @another_entry = @entries.where.not(user_id: current_user.id).first

        render json: {another_entry: @another_entry }
      end

      def create
        ActiveRecord::Base.transaction do
          group = Group.create(user_id: current_user.id)
          Entry.create!(user_id: current_user.id, group_id: group.id)
          Entry.create!(user_id: params[:user_id], group_id: group.id)
        end
      end
    end
  end
end
