class CreateSubcomponents < ActiveRecord::Migration
  def change
    create_table :subcomponents do |t|
      t.references :component
      t.references :child

      t.timestamps
    end
    add_index :subcomponents, :component_id
    add_index :subcomponents, :child_id
  end
end
