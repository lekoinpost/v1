class ContactsController < ApplicationController
  skip_before_action :authenticate_user!
  include Recaptcha::Adapters::ViewMethods
  include Recaptcha::Adapters::ControllerMethods 


  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if verify_recaptcha(model: @contact) && @contact.save
      redirect_to contacts_thanks_path
      UserMailer.with(contact: @contact).send_contact_notification.deliver_now
    else
      flash.now[:alert] = 'Merci de confirmer que vous n\'êtes pas un robot.'
      render :new
    end
  end

  def thanks
  end

  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :content)
  end

end
