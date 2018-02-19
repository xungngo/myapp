class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.secrets.mailer_from
  
  # http://domain/rails/mailers/application_mailer
  def register_email(user)
    @user = user
    mail(to: @user.email, subject: 'Thank You for Registering')
  end
end
