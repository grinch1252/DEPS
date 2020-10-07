class ApplicationController < ActionController::Base

  def home
    render html: "Hello!"
  end
end
