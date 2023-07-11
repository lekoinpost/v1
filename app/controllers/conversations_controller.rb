class ConversationsController < ApplicationController

  before_action :set_user_conversations, only: [:index, :show, :summary_title]

  def index
  end

  def show
    set_active_conversation
    if @active_conversation.appointment.giver_id == current_user.id || @active_conversation.appointment.gardener_id == current_user.id
      @message = Message.new
    else
      raise
    end
  end

  private
  
  def set_user_conversations
    @conversations = Conversation.involving_user(current_user).with_messages.sort_by { |c| c.messages.last.created_at }.reverse
    if @active_conversation.present?
      @conversations = (@conversations << @active_conversation).uniq
    end
    
  end

  def set_active_conversation
    @active_conversation = Appointment.find(params[:id]).conversation
  end

end
