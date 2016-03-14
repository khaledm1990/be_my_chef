class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  mount_uploader :image, ImageUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :events, dependent: :destroy
  has_many :bids
  has_many :messages

  has_many :active_votes, class_name:  "Vote",
  												foreign_key: "voter_id",
  												dependent: :destroy
  has_many :voting, through: :active_votes, source: :voted
  has_many :passive_votes, 	class_name:  "Vote",
  													foreign_key: "voted_id",
  													dependent: :destroy
  has_many :voters, through: :passive_votes, source: :voter

  validates :voter_id, presence: true
  validates :voted_id, presence: true

 # before_action :authenticate_user!

 	def vote(other_user, cast)
    active_votes.create(voted_id: other_user.id, cast: cast)
  end

  # Returns true if the current user is following the other user.
  def voting?(other_user)
    voting.include?(other_user)
  end

end
