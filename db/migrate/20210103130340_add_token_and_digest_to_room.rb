class AddTokenAndDigestToRoom < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :resource_token, :string
    add_column :rooms, :resource_digest, :string
  end
end
