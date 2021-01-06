class AddAnswerColumnToEntryResponse < ActiveRecord::Migration[6.0]
  def change
    add_column :entry_responses, :answer, :boolean
  end
end
