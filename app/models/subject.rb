class Subject < ApplicationRecord
  belongs_to :user, class_name: "User"
  has_many :micropost, class_name: "Micropost"
  validates :user_id, presence: true
  validates :name, presence: true, length: {maximum: 40}
  mount_uploader :picture, PictureUploader

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

end
