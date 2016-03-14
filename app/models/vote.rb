class Vote < ActiveRecord::Base
	belongs_to :voter, class_name: "User"
  belongs_to :voted, class_name: "User"
  validates :cast, presence: true
end
