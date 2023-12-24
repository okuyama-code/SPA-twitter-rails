# frozen_string_literal: true

class ApplicationController < ActionController::Base
	include DeviseTokenAuth::Concerns::SetUserByToken

	skip_before_action :verify_authenticity_token

	private

	# augment 増強する　付け足す
	def augment_with_image(tweet)
		if tweet.image.attached?
			tweet.as_json.merge(image_url: url_for(tweet.image))
		else
			tweet.as_json.merge(image_url: nil)
		end

	end

	def paginate_tweets(tweets, tweets_per_page)
		paginated_tweets = tweets.page(params[:page]).per(tweets_per_page)
		paginated_tweets.map { |tweet| augment_with_image(tweet) }
	end
end

# tweets_with_images = @tweets.map do |tweet|
# 	if tweet.image.attached?
# 		tweet.as_json.merge(image_url: url_for(tweet.image))
# 	else
# 		tweet.as_json.merge(image_url: nil)
# 	end
# end
