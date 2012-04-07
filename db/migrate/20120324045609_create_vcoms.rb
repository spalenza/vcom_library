class CreateVcoms < ActiveRecord::Migration
  def change
    create_table :vcoms do |t|
      t.string :name
      t.text :description
      t.boolean :public
      t.references :author
      t.datetime :registered_at

      t.timestamps
    end
    add_index :vcoms, :author_id
  end
end
