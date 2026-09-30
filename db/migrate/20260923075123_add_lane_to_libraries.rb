class AddLaneToLibraries < ActiveRecord::Migration[8.1]
  def change
    add_column :libraries, :lane, :integer
  end
end
