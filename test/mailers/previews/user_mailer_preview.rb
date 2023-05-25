# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  def new_message_notification
    @receiver = User.where(first_name: "Felix").first
    @sender = User.where(first_name: "Alice").first
    @conversation = Appointment.first.conversation
    UserMailer.with(receiver: @receiver, sender: @sender, conversation: @conversation).new_message_notification
  end

end
