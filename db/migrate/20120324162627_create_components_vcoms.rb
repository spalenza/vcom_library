class CreateComponentsVcoms < ActiveRecord::Migration
  def up
    create_table :components_vcoms, id: false do |t|
      t.references :vcom
      t.references :component
    end
    
    add_index :components_vcoms, :vcom_id
    add_index :components_vcoms, :component_id    
  end

  def down
  end
end
