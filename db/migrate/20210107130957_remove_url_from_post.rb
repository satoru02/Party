class RemoveUrlFromPost < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :url
  end
end
