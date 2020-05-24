#much difficulty with the 'is_password?' method.  Try creating this.

class User < ApplicationRecord
    attr_reader :password
    validates :email, :password_digest, :session_token, presence: true

    def User.generate_session_token
        SecureRandom::urlsafe_base64
    end


    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
    end

    def ensure_session_token
        self.session_token ||= User.generate_session_token
    end

    def password=(password)
        @password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        password == BCrypt::Password.new(self.password_digest)
    end
end
