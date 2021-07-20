class AgendaDeleteNoticeMailer < ApplicationMailer
  def agenda_delete_notice_mail(agenda)
    @agenda_title = agenda.title
    members = agenda.team.members
    # binding.irb
    mail to: members.map { |e| e.email }, subject: I18n.t('views.messages.delete_agenda')
  end
end
