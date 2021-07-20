class AgendaDeleteNoticeMailer < ApplicationMailer
  def agenda_delete_notice_mail(agenda)
    @members = agenda.team.members
    # binding.irb
    mail to: @members.map { |e| e.email }, subject: "notice delete agenda"
  end
end
