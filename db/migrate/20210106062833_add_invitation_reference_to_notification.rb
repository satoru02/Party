class AddInvitationReferenceToNotification < ActiveRecord::Migration[6.0]
  def change
    add_reference :notifications, :invitation, index: {unique: true }, foreign_key: true
  end
end
