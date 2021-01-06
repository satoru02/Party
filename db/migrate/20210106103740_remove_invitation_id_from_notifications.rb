class RemoveInvitationIdFromNotifications < ActiveRecord::Migration[6.0]
  def change
    remove_column :notifications, :invitation_id, index: {unique: true }, foreign_key: true
  end
end
