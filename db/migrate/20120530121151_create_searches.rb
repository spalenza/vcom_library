class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :name
      t.integer :user_id
      t.boolean :comments

      t.timestamps
    end
  end
end
