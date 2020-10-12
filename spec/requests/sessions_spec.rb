require "rails_helper"

RSpec.describe "Sessions", type: :request do
  
  let!(:user) { create(:user) }

  describe "get login_path" do
    it "submit invalid values" do
      get login_path
      expect(response).to have_http_status(:success)
      post login_path, params: {
        session: {
          email: "",
          password: ""
        }
      }
      expect(flash[:danger]).to be_truthy
      expect(is_logged_in?).to be_falsey
    end
    it "submit valid values" do
      get login_path
      expect(response).to have_http_status(:success)
      post login_path, params: {
        session: {
          email: user.email,
          password: user.password
        }
      }
      expect(flash[:danger]).to be_falsey
      expect(is_logged_in?).to be_truthy
    end
    it "login and logout" do
      get login_path
      post login_path, params: {
        session: {
          email: user.email,
          password: user.password
        }
      }
      expect(is_logged_in?).to be_truthy
      delete logout_path
      expect(is_logged_in?).to be_falsey
    end
  end
end
