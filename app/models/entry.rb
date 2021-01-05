class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_one :notification
  after_create :create_entry_notification

  # 1postに対して、ユーザーがもつEntryは一つ。

  private

    def create_entry_notification
      @target_user_id = self.post.user.id
      Notification.create!(entry_id: self.id, user_id: @target_user_id)
    end
end
