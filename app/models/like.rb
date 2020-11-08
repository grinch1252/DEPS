class Like < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  validates :has_element, presence: true

  private

    def has_element
      user_id.presence and micropost_id.presence
    end

end
