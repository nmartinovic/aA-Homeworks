class User < ApplicationRecord

    attr_reader :password

    validates :username, :session_token, presence: true
    validates :password, length: { minimum: 6, allow_nil: true }
    validates :password_digest, presence: {message: "Password cannot be blank"}


    before_validation :ensure_session_token

    def self.find_by_credentials(username, password)

        user = User.find_by(username: user)

        return nil if user.nil?

        user.password_digest.is_password?(password) ? user : nil
    end

    def self.generate_session_token
        SecureRandom::urlsafe_base64
    end

    def reset_session_token!
        self.session_token = User.generate_session_token
        self.save!
    end

    def ensure_session_token
        self.session_token ||= User.generate_session_token
    end

    def password=(pw)
        @password = pw
        self.password_digest = BCrypt::Password.create(pw)
    end
end
