module UsersHelper

  def picture_for_user_info(user, options = { size: 50 })
    if user.picture?
      size = options[:size]
      picture_url = user.picture.url
      image_tag(user.picture_url, class: "picture info-picture")
    end
  end

  def picture_for_micropost(user, options = { size: 50 })
    if user.picture?
      size = options[:size]
      picture_url = user.picture.url
      image_tag(user.picture_url, class: "picture micropost-picture")
    end
  end

  def sum_times
    @chart.values.inject(:+) unless @chart.nil?
  end

  def to_hour
    hour = sum_times / 60.0
    hour.round(2)
  end

end
