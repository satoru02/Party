class AddLimitToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :limit, :integer
  end
end
