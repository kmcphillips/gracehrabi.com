class PurchaseMailer < ActionMailer::Base
  default from: ROBOT_EMAIL

  include MailerCommon

  def created(purchase)
    @purchase = purchase

    mail(to: purchase.email, subject: "TODO")
  end

end
