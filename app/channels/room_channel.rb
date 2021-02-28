class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params[:room]}"
  end

  def unsubscribed
  end

  def speak(data)
    @room = Room.find_by(resource_token: data["room_token"])
    @user = User.find_by(id: data["user_id"])
    if @room.authenticated?(data["room_token"]) && @room.users.include?(@user)
      message = Message.create!(
        content: data["message"],
        user_id: data["user_id"],
        room_id: @room.id
      )
    end

    # 1.Inside room broadcast
    ActionCable.server.broadcast("room_channel_#{data["room_token"]}", {
      content: message.content,
      avatar: if message.user.avatar.attached? ; message.user.avatar_url(message.user.avatar.blob) end,
      user: message.user.username,
      user_id: message.user.id,
      time: message.created_at,
      token: data["room_token"] })

    # 2.Header notification broadcst
    ActionCable.server.broadcast("Notifications", {
      title: "You got a message",
      target_user_id: @room.host_id,
      attributes: message.notification,
      message_confirmation: false
    })

    # 3.Rooms broadcast
    ActionCable.server.broadcast("RoomsChannel", {
      content: message.content,
      user: message.user.username,
      user_id: message.user.id,
      time: message.created_at,
      token: data["room_token"]
    })
  end
end
