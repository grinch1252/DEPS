class Micropost < ApplicationRecord
  belongs_to :user
  default_scope { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, length: {maximum: 25}
  validates :content, length: {maximum: 255}
  validates :has_element, presence: true

  private

    def has_element
      time.presence or title.presence
    end

end
