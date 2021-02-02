class EntryResponse < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_one :notification, dependent: :destroy
  after_create :create_entry_response_notification

  private

    def create_entry_response_notification
      @target_user_id = self.user_id
      Notification.create!(entry_response_id: self.id, user_id: @target_user_id, classification: 'entryResponse')
    end
end
