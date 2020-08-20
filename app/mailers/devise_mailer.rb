class DeviseMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default from: ENV['EMAIL_FROM']

  def reset_password_instructions(record, token, opts={})
    @token = token
    @user = record
    mail(to: record.email, subject: 'Reset password instructions')
  end

end
