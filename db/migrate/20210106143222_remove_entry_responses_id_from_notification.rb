class RemoveEntryResponsesIdFromNotification < ActiveRecord::Migration[6.0]
  def change
    remove_column :notifications, :entry_responses, index: {unique: true }, foreign_key: true
  end
end
