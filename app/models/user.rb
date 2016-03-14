class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_create :confirmation_token

  mount_uploader :image, ImageUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :events, dependent: :destroy
  has_many :bids
  has_many :messages
 # before_action :authenticate_user!


# private
#   def confirmation_token
#     if self.confirm_token.blank?
#         self.confirm_token = SecureRandom.urlsafe_base64.to_s
#     end
#   end

end
