class UserMailer < ApplicationMailer
  default from: ENV.fetch('EMAIL_FROM', nil)

  def send_new_user_message(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Password Manager')
  end
end
