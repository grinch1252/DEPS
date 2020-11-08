class Event < ApplicationRecord
  belongs_to :user, class_name: "User"
  default_scope { order(start: :asc) }
  validates :has_element, presence: true
  validates :title, length: {maximum: 25}
  validates :body, length: {maximum: 255}

  private

    def has_element
      user_id.presence and start.presence and title.presence
    end

end
