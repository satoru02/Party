class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  has_one :notification, dependent: :destroy
  after_create :create_message_notification

  private

    def create_message_notification
      @target_user_id = self.room.host_id
      Notification.create!(message_id: self.id, user_id: @target_user_id, classification: 'message')
    end
end
