require 'elasticsearch/model'

class Listing < ActiveRecord::Base

		include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks


	mount_uploaders :photos, PhotosUploader
	belongs_to :user
	has_many :reservations, :dependent => :destroy

	# def mine?(user)
	# 	if user.nil?
	# else
	# 	self.user_id = user.user_id
end


# Listing.__elasticsearch__.create_index!
Listing.import # for auto sync model with elastic search