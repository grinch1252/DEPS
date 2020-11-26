module SubjectsHelper

  def picture_for_subject(subject, options = { :size => 50 })
    size = options[:size]
    if subject.picture?
      picture_url = subject.picture.url
      image_tag(subject.picture_url, :class => "picture subject-picture", :size => 100)
    else
      image_tag("no-image.jpg", :class => "picture subject-picture", :size => 100)
    end
  end
end