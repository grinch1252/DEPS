require "rails_helper"

RSpec.describe User, :type => :model do

  let!(:user) { create(:user) }
  let!(:other_user) { create(:other_user) }
  let!(:third) { create(:third) }

  context "submit valid values" do
    it "should be valid user" do
      expect(user).to be_valid
    end
  end

  describe "User validation" do
    describe "Name" do
      context "name is valid" do
        it "be valid" do
          user.name = "foobar"
          expect(user).to be_valid
        end
      end

      context "name is nil" do
        it "be invalid" do
          user.name = nil
          expect(user).to be_invalid
        end
      end

      context "name is too long" do
        it "be invalid" do
          user.name = "a" * 31
          expect(user).to be_invalid
        end
      end
    end
  end

  describe "Email" do
    context "email format is valid " do
      it "be valid" do
        user.email = "foobar@valid.com"
        expect(user).to be_valid
        user.email = "test@user.com"
        expect(user).to be_valid
        user.email = "user@example.com"
        expect(user).to be_valid
      end
    end

    context "email format is invalid" do
      it "be invalid" do
        user.email = "foobar@invalid"
        expect(user).to be_invalid
        user.email = "__test@user.bar+org"
        expect(user).to be_invalid
        user.email = "foobar@example.com.."
        expect(user).to be_invalid
      end
    end

    context "email is nil" do
      it "be invalid" do
        user.email = nil
        expect(user).to be_invalid
      end
    end

    context "email is too long" do
      it "be invalid" do
        user.email = "a" * 256 + "@example.com"
        expect(user).to be_invalid
      end
    end

    context "email is already exists" do
      it "be invalid" do
        second_user = user.dup
        second_user.email = user.email.upcase
        user.save!
        expect(second_user).to be_invalid
      end
    end

    describe "downcase before save" do
      it "be saved as downcase" do
        user.email = "USER@TEST.COM"
        user.save!
        expect(user.reload.email).to eq "user@test.com"
      end
    end
  end

  describe "Password validation" do
    context "submit valid values" do
      it "be valid" do
        user.password = "password"
        expect(user).to be_valid
      end
    end

    context "password is nil" do
      it "be invalid" do
        user.password = nil
        expect(user).to be_invalid
      end
    end

    context "password is too short" do
      it "be invalid" do
        user.password = "test"
        expect(user).to be_invalid
      end
    end

    context "doesn't match password and confimation" do
      it "be invalid" do
        user.password = "testuser"
        user.password_confirmation = "foobar"
        expect(user).to be_invalid
      end
    end
  end

  describe "authenticated?" do
    context "digest is nil" do
      it "false" do
        expect(user.authenticated?(:remember, "")).to be_falsey
      end
    end
  end

  describe "#follow and #unfollow" do
    it "follow and unfollow other user" do
      expect(user.following?(other_user)).to be_falsey
      user.follow(other_user)
      expect(user.following?(other_user)).to be_truthy
      expect(other_user.followers.include?(user)).to be_truthy
      user.unfollow(other_user)
      expect(user.following?(other_user)).to be_falsey
    end
  end

  describe "Timeline" do
    it "show following user's posts" do
      third.follow(user)
      third.microposts.each do |post_following|
        expect(user.feed.include?(post_following)).to be_truthy
      end
    end
    it "show own posts" do
      user.microposts.each do |post_self|
        expect(user.feed.include?(post_self)).to be_truthy
      end
    end
    it "doesn't show unfollowing user's posts" do
      other_user.microposts.each do |post_unfollowed|
        expect(user.feed.include?(post_unfollowed)).to be_falsey
      end
    end
  end


end
