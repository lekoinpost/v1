# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  def new_message_notification
    receiver = User.find(2) 
    sender = User.first
    conversation = Conversation.first
    UserMailer.with(receiver: receiver, sender: sender, conversation: conversation).new_message_notification
  end

  def new_appointment_notification
    appointment = Appointment.first
    UserMailer.with(appointment: appointment).new_appointment_notification
  end

  def confirmed_appointment_notification
    appointment = Appointment.first
    nb_of_points = 3
    nb_of_rewards = 2
    UserMailer.with(appointment: appointment, nb_of_points: nb_of_points, nb_of_rewards: nb_of_rewards).confirmed_appointment_notification
    
  end

end
