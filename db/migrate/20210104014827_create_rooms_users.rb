class CreateRoomsUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms_users do |t|
      t.belongs_to :user
      t.belongs_to :room
      t.timestamps
    end
  end
end
