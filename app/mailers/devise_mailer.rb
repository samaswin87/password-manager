class DeviseMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`

  default from: ENV.fetch('EMAIL_FROM', nil)

  def reset_password_instructions(record, token, _opts = {})
    @token = token
    @user = record
    mail(to: record.email, subject: 'Reset password instructions')
  end
end
