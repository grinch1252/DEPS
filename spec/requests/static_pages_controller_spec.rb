require "rails_helper"

RSpec.describe "StaticPagesController", type: :request do

  context "GET #home" do
    include ApplicationHelper
    before { get root_path }
    it "responds successfully" do
      expect(response).to have_http_status 200
    end
    it "has title 'Home | DEPS'" do
      expect(response.body).to include full_title("Home")
    end
  end

  context "GET #about" do
    include ApplicationHelper
    before { get about_path }
    it "responds successfully" do
      expect(response).to have_http_status 200
    end
    it "has title 'About | DEPS'" do
      expect(response.body).to include full_title("About")
    end
  end
end