class AddClassificationToMessage < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :classification, :string
  end
end
