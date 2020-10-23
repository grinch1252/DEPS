require "rails_helper"

RSpec.describe "User model", type: :model do

  # let(:user) { User.new(
  #   name: "TestUser",
  #   email: "Test@example.com",
  #   password: "testuser",
  #   password_confirmation: "testuser"
  # )}
  let!(:user) { create(:user) }
  let!(:other_user) { create(:other_user) }

  describe "validate user" do
    it "should be valid user" do
      expect(user).to be_valid
    end
  end

  describe "validates name" do
    it "should reject nil" do
      user.name = nil
      expect(user).to be_invalid
    end

    it "should accept valid name" do
      user.name = "foobar"
      expect(user).to be_valid
    end

    it "should reject too long name" do
      user.name = "a" * 31
      expect(user).to be_invalid
    end
  end

  describe "validates email" do
    it "should reject nil" do
      user.email = nil
      expect(user).to be_invalid
    end

    it "should reject too long email" do
      user.email = "a" * 256 + "@example.com"
      expect(user).to be_invalid
    end

    it "should accept valid email format" do
      user.email = "foobar@valid.com"
      expect(user).to be_valid
      user.email = "test@user.com"
      expect(user).to be_valid
      user.email = "user@example.com"
      expect(user).to be_valid
    end

    it "should reject invalid email format" do
      user.email = "foobar@invalid"
      expect(user).to be_invalid
      user.email = "__test@user.bar+org"
      expect(user).to be_invalid
      user.email = "foobar@example.com.."
      expect(user).to be_invalid
    end

    it "should reject existing email" do
      second_user = user.dup
      second_user.email = user.email.upcase
      user.save!
      expect(second_user).to be_invalid
    end

    it "should be saved as downcase" do
      user.email = "USER@TEST.COM"
      user.save!
      expect(user.reload.email).to eq "user@test.com"
    end
  end

  describe "validates password" do
    it "should reject nil" do
      user.password = nil
      expect(user).to be_invalid
    end

    it "should reject too short password" do
      user.password = "test"
      expect(user).to be_invalid
    end

    it "should accept valid password" do
      user.password = "password"
      expect(user).to be_valid
    end

    it "should match password and confimation" do
      user.password = "testuser"
      user.password_confirmation = "foobar"
      expect(user).to be_invalid
    end
  end

  describe "User model methods" do
    it "authenticated? method should return false if nil digest" do
      expect(user.authenticated?(:remember, "")).to be_falsey
    end
  end

  describe "User relationships" do
    it "follow and unfollow other user" do
      expect(user.following?(other_user)).to be_falsey
      user.follow(other_user)
      expect(user.following?(other_user)).to be_truthy
      expect(other_user.followers.include?(user)).to be_truthy
      user.unfollow(other_user)
      expect(user.following?(other_user)).to be_falsey
    end
  end

end
