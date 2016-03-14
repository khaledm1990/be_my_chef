class Bid < ActiveRecord::Base
	belongs_to :event
	belongs_to :user
	has_many :messages
	accepts_nested_attributes_for :messages, reject_if: proc { |a| a['content'].blank? }

	validates :event_id, uniqueness: {scope: :user_id}
	validates :price, presence: true

end