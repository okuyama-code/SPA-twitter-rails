class Api::V1::RelationshipsController < ApplicationController
  before_action :authenticate_user!

  # https://github.com/okuyama-code/hc_twitter_clone/blob/notification/app/controllers/relationships_controller.rb

  # /api/v1/users/:user_id/follow
  def create
  end

  # /api/v1/users/:user_id/unfollow
  def destroy
  end
end
