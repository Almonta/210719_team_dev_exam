class ChangeAuthorityMailer < ApplicationMailer
  def change_authority_mail(user)
    @user = user
    mail to: @user, subject: I18n.t('views.messages.complete_registration')
  end
end
