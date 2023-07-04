class UserMailer < ApplicationMailer

  before_action :add_mailer_images

  def new_message_notification
    @receiver = params[:receiver]
    @sender = params[:sender]
    @conversation = params[:conversation]
    mail(to: @receiver.email, subject: "Vous avez reçu un nouveau message sur Le Koinpost !")
  end

  def new_appointment_notification
    @gardener = params[:gardener]
    @giver = params[:giver]
    @appointment = params[:appointment]
    mail(to: @gardener.email, subject: "Vous avez un nouveau rendez-vous sur Le Koinpost !")
  end

  def confirmed_appointment_notification
    @gardener = params[:gardener]
    @giver = params[:giver]
    @appointment = params[:appointment]
    @nb_of_points = params[:nb_of_points]
    @nb_of_rewards = params[:nb_of_rewards]
    mail(to: @giver.email, subject: "Votre don a été confirmé sur Le Koinpost !")
  end

  private

  def add_mailer_images
    attachments.inline["logo.png"] = File.read("#{Rails.root}/app/assets/images/logo.png")
    # attachments.inline["instagram.png"] = File.read("#{Rails.root}/app/assets/images/instagram.png")
    # attachments.inline["facebook.png"] = File.read("#{Rails.root}/app/assets/images/facebook.png")
    # attachments.inline["twitter.png"] = File.read("#{Rails.root}/app/assets/images/twitter.png")
  end

end
