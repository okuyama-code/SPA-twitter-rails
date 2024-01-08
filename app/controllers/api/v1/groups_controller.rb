# frozen_string_literal: true

module Api
  module V1
    class GroupsController < ApplicationController
      # http://localhost:3000/api/v1/groups
      def index
        # ログインユーザー所属ルームID取得
        # current_entries = current_user.entries
        current_entries = User.find(1).entries
        my_group_id = []
        current_entries.each do |entry|
          # エントリーから取得したルームIDを my_room_id 配列に追加しています。
          my_group_id << entry.group.id
        end
        # 自分のroom_idと同じでuser_idが自分ではないentryを取得
        # another_entries = Entry.where(group_id: my_group_id).where.not(user_id: current_user.id)
        another_entries = Entry.where(group_id: my_group_id).where.not(user_id: 1)

        render json: {current_entries: current_entries, another_entries: another_entries}
      end

      def show
        @room = Room.find(params[:id])
        @messages = @room.messages.all
        @message = Message.new
        @entries = @room.entries
        @another_entry = @entries.where.not(user_id: current_user.id).first
      end

      # before_action :authenticate_user!
      # users/showページで@is_roomがない時にformでパラメーターが送られてきてcreateアクションが走る。
      # 現在ログインしているユーザーとメッセージ相手のユーザーそれぞれの情報をroom_idで紐付けてEntryテーブルに２つレコードを作成している。

      # TODO RoomをGroupに変換
      # params[:user_id]でshowのidを渡す
      def create
        pp "デバック！！！！！！！！！！！！！"
        pp current_user
        pp params[:user_id]
        ActiveRecord::Base.transaction do
          group = Group.create(user_id: current_user.id)
          Entry.create!(user_id: current_user.id, group_id: group.id)
          Entry.create!(user_id: params[:user_id], group_id: group.id)
        end
      end
    end
  end
end
