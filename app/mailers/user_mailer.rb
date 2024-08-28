class UserMailer < ApplicationMailer

  before_action :add_mailer_images

  def new_message_notification
    @receiver = params[:receiver]
    @sender = params[:sender]
    @conversation = params[:conversation]
    mail(to: @receiver.email, subject: "Vous avez reçu un nouveau message sur Le Koinpost !")
  end

  def new_appointment_notification
    @appointment = params[:appointment]
    mail(to: @appointment.gardener.email, subject: "Vous avez un nouveau rendez-vous sur Le Koinpost !")
  end

  def confirmed_appointment_notification
    @appointment = params[:appointment]
    @nb_of_points = params[:nb_of_points]
    @nb_of_rewards = params[:nb_of_rewards]
    mail(to: @appointment.giver.email, subject: "Votre don a été confirmé sur Le Koinpost !")
  end

  def send_contact_notification
    @contact = params[:contact]
    # TO DO : update this email address to lekoinpost2023@gmail.com
    mail(to: "noemie.pierart@gmail.com", subject: "Vous avez reçu un nouveau message sur le Koinpost !" )
  end


  private

  def add_mailer_images
    attachments.inline["logo.png"] = File.read("#{Rails.root}/app/assets/images/logo.png")
    attachments.inline["instagram.png"] = File.read("#{Rails.root}/app/assets/images/instagram.png")
    attachments.inline["facebook.png"] = File.read("#{Rails.root}/app/assets/images/facebook.png")
    attachments.inline["linkedin.png"] = File.read("#{Rails.root}/app/assets/images/linkedin.png")
  end

end
