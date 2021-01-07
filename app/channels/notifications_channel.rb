class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "Notifications"
  end

  def unsubscribed
  end
end