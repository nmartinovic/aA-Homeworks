
class User < ApplicationRecord
        attr_reader :password

        validates :email, null:false, presence: true
        validates :password, length: { minimum: 6, allow_nil: true}, presence: true
        validates :password_digest, presence: true

        after_initialize :ensure_session_token
    # t.string :email, null: false
    # t.string :password_digest, null: false
    # t.string :session_token, null: false

    def self.find_by_credentials(email, password)
        @user = User.find_by(email: email)
        if @user.is_password?(password)
            @user
        else
            nil
        end
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end


    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def reset_session_token!
        self.session_token = generate_unique_session_token
    end

    def ensure_session_token
        self.session_token ||= generate_unique_session_token
    end

    def generate_unique_session_token
        SecureRandom::urlsafe_base64
    end
end
