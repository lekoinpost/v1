class ContactsController < ApplicationController
  skip_before_action :authenticate_user!
  include Recaptcha::Adapters::ViewMethods
  include Recaptcha::Adapters::ControllerMethods 


  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.valid?
      if verify_recaptcha(model: @contact) 
        @contact.save
        redirect_to contacts_thanks_path
      else 
        @contact.errors.add(:recaptcha, "Merci de confirmer que vous n'êtes pas un robot.") unless verify_recaptcha
        flash.now[:alert] = 'Merci de bien compléter le formulaire RECAPTCHA.'
        render :new, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = 'Merci de bien compléter le formulaire.'
      render :new, status: :unprocessable_entity
    end
  end

  def thanks
  end

  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :content)
  end

end
