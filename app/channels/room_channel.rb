class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params[:room]}"
  end

  def unsubscribed
  end

  def speak(data)
    message = Message.create!(content: data["message"])
    ActionCable.server.broadcast("room_channel_#{params[:room]}", { message: message })
  end
end
