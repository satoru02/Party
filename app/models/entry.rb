class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_one :notification, dependent: :destroy
  after_create :create_entry_notification
  validates_uniqueness_of :user_id, :scope => [:post_id]

  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def deactivate
    update_columns(activated: false)
  end

  private

    def create_entry_notification
      @target_user_id = self.post.user.id
      Notification.create!(entry_id: self.id, user_id: @target_user_id, classification: 'entry')
    end
end
