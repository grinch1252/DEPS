class Micropost < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  default_scope { order(created_at: :desc) }
  validates :has_element, presence: true
  validates :title, length: {maximum: 25}
  validates :content, length: {maximum: 255}
  validates :time, :numericality => { :greater_than_or_equal_to => 0 }

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
      user_id.presence and title.presence and content.presence
    end

end
