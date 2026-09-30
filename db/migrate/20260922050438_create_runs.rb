class CreateRuns < ActiveRecord::Migration[8.1]
  def change
    create_table :runs do |t|
      t.references :platform, null: false, foreign_key: true
      t.string :location
      t.string :name
      t.date :run_date
      t.boolean :demuxed
      t.text :comments

      t.timestamps
    end
  end
end
