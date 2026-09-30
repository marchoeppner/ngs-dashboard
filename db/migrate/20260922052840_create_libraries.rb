class CreateLibraries < ActiveRecord::Migration[8.1]
  def change
    create_table :libraries do |t|
      t.string :accession
      t.string :name
      t.references :platform, null: false, foreign_key: true
      t.references :run, null: false, foreign_key: true
      t.integer :read_count
      t.string :read_length
      t.float :q30

      t.timestamps
    end
  end
end
