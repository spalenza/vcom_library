class CreateAttributes < ActiveRecord::Migration
  def change
    create_table :attributes do |t|
      t.references :element
      t.string :name
      t.string :value

      t.timestamps
    end
    add_index :attributes, :element_id
  end
end
