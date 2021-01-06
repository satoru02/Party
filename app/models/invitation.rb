class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_one :notification
  after_create :create_invitation_notification

  private

    def create_invitation_notification
      @target_user_id = self.user_id
      Notification.create!(invitation_id: self.id, user_id: @target_user_id)
    end
end
