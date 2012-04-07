class AddFileToVcoms < ActiveRecord::Migration
  def change
    add_column :vcoms, :attachment, :string

  end
end
