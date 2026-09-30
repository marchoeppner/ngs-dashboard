class CreatePipelines < ActiveRecord::Migration[8.1]
  def change
    create_table :pipelines do |t|
      t.string :name
      t.integer :version
      t.string :template
      t.string :description
      t.boolean :run_level
      t.text :samplesheet_format
      t.boolean :job_level

      t.timestamps
    end
  end
end
