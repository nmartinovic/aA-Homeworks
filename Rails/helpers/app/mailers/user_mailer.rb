class UserMailer < ApplicationMailer
    default from: "nick@99cats.com"

    def welcome_email(user)
        @user = user
        mail(to: user.username, subject: "Thanks for signing up")
    end
end
