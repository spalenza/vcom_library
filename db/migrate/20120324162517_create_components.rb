class CreateComponents < ActiveRecord::Migration
  def change
    create_table :components do |t|
      t.string :name
      t.references :vcom

      t.timestamps
    end
    
    add_index :components, :vcom_id
  end
end
