class Location < ActiveRecord::Base
	belongs_to :event
	validates :postal_code, presence: true
end
	