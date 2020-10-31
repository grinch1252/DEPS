class Subject < ApplicationRecord
  belongs_to :user, class_name: "User"
  validates :user_id, presence: true
  validates :name, presence: true, length: {maximum: 40}
end
