class CreateVcoms < ActiveRecord::Migration
  def change
    create_table :vcoms do |t|
      t.string :name
      t.string :description
      t.string :xml_path
      t.boolean :public
      t.references :user

      t.timestamps
    end
    add_index :vcoms, :user_id
  end
end
