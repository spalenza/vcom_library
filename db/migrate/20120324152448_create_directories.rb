class CreateDirectories < ActiveRecord::Migration
  def change
    create_table :directories do |t|
      t.string :name
      t.references :user
      t.boolean :fixed, :default => false

      t.timestamps
    end
    
    add_index :directories, :user_id
  end
end
