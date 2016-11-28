class Listing < ActiveRecord::Base
	mount_uploaders :photos, PhotosUploader
	belongs_to :user
	has_many :reservations, :dependent => :destroy

	def mine?(user)
		if user.nil?
	else
		self.user_id = user.user_id
	end
end
