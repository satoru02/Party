class Notification < ApplicationRecord
  belongs_to :user
  include Pager

  def checked
    self.update!(confirmation: true)
  end

  def message_checked(room)
    if self.update!(confirmation: true)
      ActionCable.server.broadcast("Notifications", {
        title: "Message is readen.",
        target_user_id: room.host_id,
        attributes: self,
        message_confirmation: true
      })
    end
  end
end
