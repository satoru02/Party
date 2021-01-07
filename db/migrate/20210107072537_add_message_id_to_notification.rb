class AddMessageIdToNotification < ActiveRecord::Migration[6.0]
  def change
    add_reference :notifications, :message, index: {unique: true }, foreign_key: true
  end
end
