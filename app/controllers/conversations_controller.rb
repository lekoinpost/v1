class ConversationsController < ApplicationController

  before_action :set_user_conversations, only: [:index, :show, :summary_title]

  def index
    @active_conversation = @conversations.last
    if !@active_conversation.nil?
      @conversations = @conversations[0..-2]
    end
  end

  def show
    @active_conversation = Appointment.find(params[:id]).conversation
    @conversations = @conversations.reject { |c| c.id == @active_conversation.id }
    if @active_conversation.appointment.giver_id == current_user.id || @active_conversation.appointment.gardener_id == current_user.id
      @message = Message.new
    else
      raise
    end
  end

  private
  
  def set_user_conversations
    @conversations = Conversation.involving_user(current_user).with_messages.sort_by { |c| c.messages.last.created_at }.reverse
  end

  def set_active_conversation
    
  end

end
