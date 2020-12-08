class OrderMailer < ApplicationMailer
  def create_order user, order
    @order = order
    @user = user
    mail to: user.email, subject: t("subject_mail_order_new")
  end
end
