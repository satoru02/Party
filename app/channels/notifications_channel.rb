class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "Notification_from_#{current_user.id}"
    stream_from "Notifications"
  end

  def unsubscribed
  end
end