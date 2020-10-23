class Event < ApplicationRecord
  belongs_to :user
  default_scope { order(start: :asc) }
  validates :user_id, presence: true
  validates :title, length: {maximum: 25}
  validates :body, length: {maximum: 255}
  validates :has_element, presence: true
  validates :start, presence: true

  private

    def has_element
      start.presence or title.presence or body.presence
    end

end
