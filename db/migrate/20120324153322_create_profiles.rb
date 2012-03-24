class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user
      t.string :name
      t.string :image

      t.timestamps
    end
    add_index :profiles, :user_id
  end
end
