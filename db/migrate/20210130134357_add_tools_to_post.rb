class AddToolsToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :tools, :text, array: true, default: []
  end
end
