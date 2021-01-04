class AddHostToRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :host_id, :integer
  end
end
