class RemoveDateFromPost < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :date
  end
end
