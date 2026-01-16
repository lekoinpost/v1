class ContactsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to merci_pour_votre_message_path
    else
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
