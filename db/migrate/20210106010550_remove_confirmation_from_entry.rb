class RemoveConfirmationFromEntry < ActiveRecord::Migration[6.0]
  def change
    remove_column :entries, :confirmation, :boolean
  end
end
