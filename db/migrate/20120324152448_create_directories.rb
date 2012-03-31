class CreateDirectories < ActiveRecord::Migration
  def change
    create_table :directories do |t|
      t.string :name
      t.references :user

      t.timestamps
    end
    
    add_index :directories, :user_id
  end
end
