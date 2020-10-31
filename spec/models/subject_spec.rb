require "rails_helper"

RSpec.describe Subject, type: :model do

  let(:user) { create(:user) }
  let(:subject) { user.subjects.build(name: "Test",
                                      total_time: 0,
                                      user_id: user.id)}

  context "submit valid values" do
    it "be valid" do
      expect(subject).to be_valid
    end
  end

  describe "subject validation" do
    context "user_id is nil" do
      it "be invalid" do
        subject.user_id = nil
        expect(subject).to be_invalid
      end
    end

    context "name is nil" do
      it "be invalid" do
        subject.name = nil
        expect(subject).to be_invalid
      end
    end

    context "name is too long" do
      it "be invalid" do
        subject.name = "A" * 50
        expect(subject).to be_invalid
      end
    end
  end

end
