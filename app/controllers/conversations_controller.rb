class ConversationsController < ApplicationController

  before_action :set_user_conversations, only: [:index, :show, :summary_title]

  def index
  end

  def show
    @active_conversation = Conversation.find(params[:id])
    if @active_conversation.appointment.giver_id == current_user.id || @active_conversation.appointment.gardener_id == current_user.id
      @message = Message.new
    else
      raise
    end
  end

  private
  
  def set_user_conversations
    @conversations = Conversation.involving_user(current_user).with_messages
  end

end
