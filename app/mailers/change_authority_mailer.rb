class ChangeAuthorityMailer < ApplicationMailer
  def change_authority_mail(user)
    mail to: user.email, subject: I18n.t('views.messages.change_authority')
  end
end
