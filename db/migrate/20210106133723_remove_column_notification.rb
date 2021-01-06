class RemoveColumnNotification < ActiveRecord::Migration[6.0]
  def change
    remove_column :notifications, :type, :integer
  end
end
