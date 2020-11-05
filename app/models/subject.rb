class Subject < ApplicationRecord
  belongs_to :user, class_name: "User"
  has_many :micropost, class_name: "Micropost"
  validates :user_id, presence: true
  validates :name, presence: true, length: {maximum: 40}
  mount_uploader :picture, PictureUploader

end
