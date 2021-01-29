class AddConfirmationToMessage < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :confirmation, :boolean, default: :false
  end
end
