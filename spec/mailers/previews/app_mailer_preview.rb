# Preview all emails at http://localhost:3000/rails/mailers/app_mailer
class AppMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/app_mailer/send_order_summary_email
  def send_order_summary_email
    AppMailer.send_order_summary_email(User.last)
  end

  # Preview this email at http://localhost:3000/rails/mailers/app_mailer/send_welcome_email
  def send_welcome_email
    AppMailer.send_welcome_email(User.last)
  end
end
