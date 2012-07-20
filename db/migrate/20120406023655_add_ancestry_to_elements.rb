class AddAncestryToElements < ActiveRecord::Migration
  def change
    add_column :elements, :ancestry, :string
    add_index :elements, :ancestry
  end
end
