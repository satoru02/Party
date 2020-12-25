class AddFilmarksUrlToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :filmarks_url, :string
  end
end
