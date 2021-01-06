class CreateEntryResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :entry_responses do |t|
      t.belongs_to :user
      t.belongs_to :post
      t.timestamps
    end
  end
end
