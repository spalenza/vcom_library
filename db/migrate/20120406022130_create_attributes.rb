class CreateAttributes < ActiveRecord::Migration
  def change
    create_table :attributes do |t|
      t.references :component
      t.string :name
      t.string :value

      t.timestamps
    end
    add_index :attributes, :component_id
  end
end
