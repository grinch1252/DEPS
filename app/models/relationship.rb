class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :has_element, presence: true

  private

    def has_element
      follower_id.presence and followed_id.presence
    end

end
