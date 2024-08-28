class ContactsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to contacts_thanks_path
      UserMailer.with(contact: @contact).send_contact_notification.deliver_now
    else
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
