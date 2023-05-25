class UserMailer < ApplicationMailer

  before_action :add_mailer_images

  def new_message_notification
    @receiver = params[:receiver]
    @sender = params[:sender]
    @conversation = params[:conversation]
    mail(to: @receiver.email, subject: "Vous avez reçu un nouveau message sur Le Koinpost !")
  end

  private

  def add_mailer_images
    attachments.inline["logo.png"] = File.read("#{Rails.root}/app/assets/images/logo.png")
    # attachments.inline["instagram.png"] = File.read("#{Rails.root}/app/assets/images/instagram.png")
    # attachments.inline["facebook.png"] = File.read("#{Rails.root}/app/assets/images/facebook.png")
    # attachments.inline["twitter.png"] = File.read("#{Rails.root}/app/assets/images/twitter.png")
  end

end
