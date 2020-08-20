class UserMailer < ApplicationMailer
  default from: ENV['EMAIL_FROM']

  def send_new_user_message(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Password Manager')
  end

end
