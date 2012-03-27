class CreateComponents < ActiveRecord::Migration
  def change
    create_table :components do |t|
      t.string :name
      t.string :description
      t.references :component

      t.timestamps
    end
    
    add_index :components, :component_id    
  end
end
