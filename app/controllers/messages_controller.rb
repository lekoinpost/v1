class MessagesController < ApplicationController
  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = Message.new(message_params)
    @message.conversation = @conversation
    @message.sender = current_user
    if current_user.has_a_garden?
      @message.receiver = @conversation.appointment.giver
    else 
      @message.receiver = @conversation.appointment.gardener
    end
    if @message.save
      ConversationChannel.broadcast_to(
        @conversation,
        render_to_string(partial: "message", locals: {message: @message})
      )
      head :ok
      UserMailer.with(sender: @message.sender, receiver: @message.receiver, conversation: @conversation).new_message_notification.deliver_now
    else
      render "conversations/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end