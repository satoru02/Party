class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params[:room]}"
  end

  def unsubscribed
  end

  def speak(data)
    @room = Room.find_by(resource_token: data["room_token"])
    if @room.authenticated?(data["room_token"])
      message = Message.create!(
        content: data["message"],
        user_id: data["user_id"],
        room_id: @room.id
      )
    end
    ActionCable.server.broadcast("room_channel_#{params[:room]}", { message: message })
  end
end
