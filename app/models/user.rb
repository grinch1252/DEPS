class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  attr_accessor :remember_token, :activation_token, :reset_token
  mount_uploader :picture, PictureUploader
  has_one_attached :picture
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  before_save :downcase_email
  before_create :create_activation_digest
  validates :name,  presence: true,
                    length: {maximum: 30}
  validates :email, presence: true,
                    length: {maximum: 255},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password,  presence: true,
                        length: {minimum: 6},
                        allow_nil: true

class << self
  def new_token
    SecureRandom.urlsafe_base64
  end

  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end

def remember
  self.remember_token = User.new_token
  update_attribute(:remember_digest, User.digest(remember_token))
end

def authenticated?(attribute, token)
  digest = send("#{attribute}_digest")
  return false if digest.nil?
  BCrypt::Password.new(digest).is_password?(token)
end

def forget
  update_attribute(:remember_digest, nil)
end

def activate
  update_attribute(:activated, true)
end

def send_activation_email
  UserMailer.account_activation(self).deliver_now
end

def create_reset_digest
  self.reset_token = User.new_token
  update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
end

def send_password_reset_email
  UserMailer.password_reset(self).deliver_now
end

def password_reset_expired?
  reset_sent_at < 2.hours.ago
end

def microposts_period(period)
  current = Time.current.beginning_of_day
  case period
  when "week"
    start_date = current.ago(6.days)
  when "month"
    start_date = current.ago(1.month - 1.day)
  when "year"
    start_date = current.ago(1.year - 1.day)
  else
    start_date = current.ago(6.days)
  end
  end_date = Time.current
  dates = {}
  (start_date.to_datetime...end_date.to_datetime).each do |date|
    microposts = self.microposts.where(created_at: date.beginning_of_day...date.end_of_day)
    sum_times = microposts.sum(:time)
    dates.store(date.to_date.to_s, sum_times)
  end
  return dates
end

  private

    def downcase_email
      email.downcase!
    end

    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

end
