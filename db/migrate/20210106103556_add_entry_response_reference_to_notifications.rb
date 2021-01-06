class AddEntryResponseReferenceToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_reference :notifications, :entry_responses, index: {unique: true }, foreign_key: true
  end
end
