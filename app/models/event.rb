class Event < ApplicationRecord
  belongs_to :user, class_name: "User"
  default_scope { order(start: :asc) }
  validates :user_id, presence: true
  validates :title, length: {maximum: 25}
  validates :body, length: {maximum: 255}
  validates :has_element, presence: true
  validates :start, presence: true

  private

    def has_element
      start.presence and title.presence
    end

end
