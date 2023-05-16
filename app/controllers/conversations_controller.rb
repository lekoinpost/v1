class ConversationsController < ApplicationController

  before_action :set_user_conversations, only: [:index, :show]

  def index
  end

  def show
    @active_conversation = Conversation.find(params[:id])
    @message = Message.new
  end

  private
  
  def set_user_conversations
    @conversations = Conversation.involving_user(current_user).with_messages
  end

end
