class CreateDirectoriesVcoms < ActiveRecord::Migration
  def up
    create_table :directories_vcoms, id: false do |t|
      t.references :vcom
      t.references :directory
    end

    add_index :directories_vcoms, :vcom_id    
    add_index :directories_vcoms, :directory_id
  end

  def down
    drop_table :directories_vcoms
  end
end
