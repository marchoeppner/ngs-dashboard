class CreateInstruments < ActiveRecord::Migration[8.1]
  def change
    create_table :instruments do |t|
      t.string :name, null: false
      t.string :nickname
      t.string :nfs_path, null: false
      t.integer :platform, default: 0, null: false

      t.timestamps
    end
  end
end
