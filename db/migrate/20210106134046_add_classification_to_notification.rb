class AddClassificationToNotification < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :classification, :string
  end
end
