# require 'elasticsearch/model'

class Listing < ActiveRecord::Base

		# include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks


	mount_uploaders :photos, PhotosUploader
	belongs_to :user
	has_many :reservations, :dependent => :destroy

	# def mine?(user)
	# 	if user.nil?
	# else
	# 	self.user_id = user.user_id
  include PgSearch
  pg_search_scope :search, against: [:location, :title, :description],
    using: {tsearch: {dictionary: "english"}}
  scope :price_min, -> (price_min) {where("price >= ?", price_min)}
  scope :price_max, -> (price_max) {where("price <= ?", price_max)}
  scope :limit_location, -> (location) {where("location like ?", "%#{location}%")}
  

  def self.text_search(query)
    if query.present?
      search(query)
    else
      self
    end
  end


end



# # Listing.__elasticsearch__.create_index!
# Listing.import # for auto sync model with elastic search