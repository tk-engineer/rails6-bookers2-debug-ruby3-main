class ChatsController < ApplicationController
  def show
    @other_user = User.find(params[:id])
    
    chat_room = ChatRoom.joins(:chat_room_users)
                        .where(chat_room_users: { user_id: [current_user.id, @other_user.id] })
                        .group('chat_rooms.id')
                        .having('COUNT(chat_rooms.id) = 2')
                        .first
                        
    if chat_room.nil?
      chat_room = ChatRoom.create
      ChatRoomUser.create(chat_room: chat_room, user: current_user)
      ChatRoomUser.create(chat_room: chat_room, user: @other_user)
    end
    
    @messages = chat_room.messages
    @message = Message.new
    
  end
  
  def create
    @other_user = User.find(params[:id])
    
    chat_room = ChatRoom.joins(:chat_room_users)
                        .where(chat_room_users: { user_id: [current_user.id, @other_user.id] })
                        .group('chat_rooms.id')
                        .having('COUNT(chat_rooms.id) = 2')
                        .first
    
    @message = chat_room.messages.build(message_params)
    @message.user = current_user
    @message.save
    redirect_to chat_path(@other_user)
  end
  
  private
  
  def message_params
    params.require(:message).permit(:content)
  end
end
