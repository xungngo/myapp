class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.secrets.mailer_from
  
  # http://localhost:3333/rails/mailers/application_mailer
  def register_email(user)
    @user = user
    mail(to: @user.email, subject: 'Thank You for Registering')
  end
end
