class AppMailer < ActionMailer::Base
  default from: "info@twill-store.com"

  def send_order_summary_email(user)
    @user = user
    mail to: user.email, subject: "Order Summary"
  end

  def send_welcome_email(user)
    @user = user
    mail to: user.email, subject: "Welcome to Twill-Store"
  end
end
