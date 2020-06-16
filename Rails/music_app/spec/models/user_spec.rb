require 'rails_helper'

RSpec.describe User, type: :model do

  subject(:nick) { User.new(email: "nick", password_digest: nil, session_token: nil) }
  describe "validations" do 
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_length_of(:password) }
  end

  describe '#is_password?' do
    it "should validate the password" do
      nick = User.create(email:'nick',password:'nicknick')
      expect(nick.is_password?('nicknick')).to eq(true)
    end
  end

  describe '#reset_session_token' do
    it 'should validate the session token changes' do
      nick = User.create(email:'nick',password:'nicknick')
      tmp_token = nick.session_token
      nick.reset_session_token!
      expect(tmp_token).not_to eq(nick.session_token)
    end
  end

  describe '::find_by_credentials' do
    it 'should find the user' do
      nick = User.create(email:'nick',password:'nicknick')
      expect(User.find_by(email: 'nick').where_values_hash).to eq({'email' => 'nick'})
    end
  end

end
