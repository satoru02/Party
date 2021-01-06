class AddActivatedTimeToEntry < ActiveRecord::Migration[6.0]
  def change
    add_column :entries, :activated_at, :datetime
  end
end
