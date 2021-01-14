class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    stream_from "AppearanceChannel"
    current_user.check_online
  end

  def unsubscribed
  end
end
