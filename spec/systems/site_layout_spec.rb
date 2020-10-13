require "rails_helper"

RSpec.describe "Site layouts", type: :system do

  describe "home" do
    it "has root link" do
      visit root_path
      expect(page).to have_link nil, href: root_path, count: 1
    end

    it "has login link" do
      visit root_path
      expect(page).to have_link "Login", href: login_path
    end
  end
end