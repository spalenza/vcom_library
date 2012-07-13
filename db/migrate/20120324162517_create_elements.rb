class CreateElements < ActiveRecord::Migration
  def change
    create_table :elements do |t|
      t.string :name
      t.references :vcom

      t.timestamps
    end

    add_index :elements, :vcom_id
  end
end