class RemoveEntryResponsesIdColumnFromNotification < ActiveRecord::Migration[6.0]
  def change
    remove_column :notifications, :entry_responses_id
  end
end
