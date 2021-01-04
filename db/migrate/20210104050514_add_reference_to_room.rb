class AddReferenceToRoom < ActiveRecord::Migration[6.0]
  def change
    add_reference :rooms, :post, index: {unique: true }, foreign_key: true
  end
end
