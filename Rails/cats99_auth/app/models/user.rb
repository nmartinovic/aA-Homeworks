class User < ApplicationRecord
    attr_reader :password
    validates :user_name, :password_digest, presence: true

    after_initialize :set_session_token

    def self.find_by_credentials(user_name, password)
        user = User.find_by(user_name: user_name)

        return nil if user.nil?

        user.is_password?(password) ? user : nil
    end

    def set_session_token
        #self.session_token ||= self.session_token = SecureRandom::urlsafe_base64
        #self.save!
        if self.session_token.nil?
            self.session_token = SecureRandom::urlsafe_base64
            self.save!
        end
    end

    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        self.password_digest.is_password?(password)
    end

    def password_digest
        BCrypt::Password.new(super)
    end
end
