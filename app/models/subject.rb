class Subject < ApplicationRecord
  belongs_to :user, :class_name => "User"
  has_many :micropost, :class_name => "Micropost"
  validates :has_element, :presence => true
  validates :name, :length => { :maximum => 40 }
  mount_uploader :picture, PictureUploader

  private

    def has_element
      user_id.presence and name.presence
    end

end
