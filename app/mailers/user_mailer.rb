class UserMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  default from: '<no-reply@feelingyt.com>'

  def registration_confirmation(record, token, opts={})
   @token = token
   #you can add your instance variables here
   @first_name = record.first_name
   devise_mail(record, :confirmation_instructions, opts)
  end
end
