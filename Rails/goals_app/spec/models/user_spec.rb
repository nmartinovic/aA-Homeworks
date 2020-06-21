require 'rails_helper'

RSpec.describe User, type: :model do
  describe User do
    subject(:user) do
      FactoryBot.build(:user,
        email: "jonathan@fakesite.com",
        password: "good_password")
    end
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password).is_at_least(6) }


  describe '::find_by_credentials' do
    before { user.save! }

    it "returns user given good credentials" do
      expect(User.find_by_credentials("jonathan@fakesite.com", "good_password")).to eq(user)
    end
  end


  describe '#password=' do
    it "validates the correct password" do
      expect(user.password).to eq("good_password")
    end

    it "returns false when a password is incorrect" do
      expect(user.password).not_to eq("poop")
    end
  end

  describe '#is_password?' do
    it "returns true when passed the correct password for a user" do
      expect(user.is_password?("good_password")).to be(true)
    end

    it "returns false when passed the incorrect password for a user" do
      expect(user.is_password?("poop")).to be(false)
    end
  end

  describe "reset_session_token!" do
    it "validates that session token changes when called" do
      tmp_token = user.session_token
      user.reset_session_token!
      expect(user.session_token).not_to eq(tmp_token)
    end
  end

  describe "ensure_session_token" do
    it "ensures that a session token is set" do
      user.ensure_session_token
      expect(user.session_token).not_to eq(nil)
    end
  end
  end


end
