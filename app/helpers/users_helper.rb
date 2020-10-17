module UsersHelper

  def picture_for(user, options = { size: 50 })
    if user.picture?
      size = options[:size]
      picture_url = user.picture.url
      image_tag(user.picture_url, class: "picture")
    end
  end

end
