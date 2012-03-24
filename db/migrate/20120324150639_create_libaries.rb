class CreateLibaries < ActiveRecord::Migration
  def change
    create_table :libaries do |t|
      t.references :user

      t.timestamps
    end
    add_index :libaries, :user_id
  end
end
