# Preview all emails at http://localhost:3333/rails/mailers/application_mailer
class ApplicationMailerPreview < ActionMailer::Preview
    def register_email_preview
      ApplicationMailer.register_email(User.first)
    end
  end