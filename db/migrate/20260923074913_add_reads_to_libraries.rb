class AddReadsToLibraries < ActiveRecord::Migration[8.1]
  def change
    add_column :libraries, :R1, :string
    add_column :libraries, :R2, :string
  end
end
