class CreateDirectories < ActiveRecord::Migration
  def change
    create_table :directories do |t|
      t.string :name
      t.references :libary

      t.timestamps
    end
    add_index :directories, :libary_id
  end
end
