class Event < ActiveRecord::Base
	belongs_to :users
	has_one :location, dependent: :destroy
	accepts_nested_attributes_for :location

	validates :user_id, presence: true
	validates :name, presence: true
	validates :date, presence: true

	# before_action :authenticate_user!

	def start_time
		starting_time.try(:strftime, "%H:%M")
	end

	def start_time=(time)
		self.starting_time = Time.zone.parse(time)
	end

	def end_time
		ending_time.try(:strftime, "%H:%M")
	end

	def end_time=(time)
		self.ending_time = Time.zone.parse(time)
	end

end
