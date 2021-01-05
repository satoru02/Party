class AddConfirmationToEntry < ActiveRecord::Migration[6.0]
  def change
    add_column :entries, :confirmation, :boolean, default: :false
  end
end
