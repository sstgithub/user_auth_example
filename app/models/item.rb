class Item < ActiveRecord::Base
	belongs_to :wishlist

	before_create :get_etsy_id #CALLBACK - FIND OUT MORE -- 40:30 in screencast -- will autosave on initial create if you use before_create rather than after_create

	def get_etsy_id
		string = self.etsy_url
		regex = /\d+/
		numbers = string.scan(regex)
		self[:etsy_id] = numbers[0]
	end

	def set_attributes_from_etsy
		etsy_data = get_etsy_data
		listing = etsy_data["results"][0]
		self[:name] = listing["title"]
		self[:description] = listing["description"]
		self[:price] = listing["price"]
		self[:user_id] = listing["user_id"]
		self.save
	end

	def set_image_attributes_from_etsy
		etsy_data = get_image_etsy_data
		image = etsy_data["results"][0]
		self[:image_id] = image["listing_image_id"]
		self[:image_75x75] = image["url_75x75"]
		self.save
	end

	def set_user_attributes_from_etsy
		etsy_data = get_user_etsy_data
		user = etsy_data["results"][0]
		self[:feedback_count] = user["feedback_info"]["count"]
		self[:feedback_score_percent] = user["feedback_info"]["score"]
		self.save
	end


	def get_etsy_data
		HTTParty.get("https://openapi.etsy.com/v2/listings/#{self.etsy_id}?api_key=#{Rails.application.secrets.etsy_api_key_value}")
	end

	def get_image_etsy_data
		HTTParty.get("https://openapi.etsy.com/v2/listings/#{self.etsy_id}/images?api_key=#{Rails.application.secrets.etsy_api_key_value}")
	end

	def get_user_etsy_data
		HTTParty.get("https://openapi.etsy.com/v2/users/#{self.user_id}?api_key=#{Rails.application.secrets.etsy_api_key_value}")
	end

	def get_keyword_etsy_data(keyword)
		HTTParty.get("https://openapi.etsy.com/v2/listings/active?keywords=#{keyword}&api_key=#{Rails.application.secrets.etsy_api_key_value}")
	end



	def self.by_keyword(keyword) #just show the hash
		HTTParty.get("https://openapi.etsy.com/v2/listings/active?keywords=#{keyword}&limit=100&offset=0&api_key=#{Rails.application.secrets.etsy_api_key_value}")
	end #only show ones that have high enough feedback *and show them with picture thumbnails*


end
