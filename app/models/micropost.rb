class Micropost < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  default_scope { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, length: {maximum: 25}
  validates :content, length: {maximum: 255}
  validates :has_element, presence: true

  def like(user)
    likes.create(user_id: user.id)
  end

  def unlike(user)
    likes.find_by(user_id: user.id).destroy
  end

  def liked?(user)
    liked_users.include?(user)
  end

  private

    def has_element
      time.presence or title.presence or content.presence
    end

end
