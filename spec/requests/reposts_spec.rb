# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reposts' do
  describe 'GET /create' do
    it 'returns http success' do
      get '/reposts/create'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /destroy' do
    it 'returns http success' do
      get '/reposts/destroy'
      expect(response).to have_http_status(:success)
    end
  end
end
