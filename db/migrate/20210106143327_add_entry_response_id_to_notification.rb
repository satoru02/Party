class AddEntryResponseIdToNotification < ActiveRecord::Migration[6.0]
  def change
    add_reference :notifications, :entry_response, index: {unique: true }, foreign_key: true
  end
end
