class Listing < ApplicationRecord
	belongs_to :users
	mount_uploaders :images, AvatarUploader

	def self.search(search)
	  where("name ILIKE ? OR state ILIKE ? OR city ILIKE ? OR country ILIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%") 
	end
end