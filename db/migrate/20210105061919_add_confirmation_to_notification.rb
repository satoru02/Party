class AddConfirmationToNotification < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :confirmation, :boolean, default: :false
  end
end
