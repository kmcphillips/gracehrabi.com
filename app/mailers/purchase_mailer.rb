class PurchaseMailer < ActionMailer::Base
  default from: ROBOT_EMAIL = "\"GraceHrabi\" <#{ SITE_EMAIL }>"

  include MailerCommon
  add_template_helper(DownloadHelper)

  def created(purchase)
    @purchase = purchase

    mail(to: purchase.email, bcc: [site_email, admin_email], subject: "Download link for #{ purchase.download.name } from GraceHrabi.com")
  end

end
