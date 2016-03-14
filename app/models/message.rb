class Message < ActiveRecord::Base
	belongs_to :bid
	belongs_to :user

	# validates :user_id, presence: true
	# validates :bid_id, presence: true

end