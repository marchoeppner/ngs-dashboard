class CreateXrefJobLibraries < ActiveRecord::Migration[8.1]
  def change
    create_table :xref_job_libraries do |t|
      t.references :job, null: false, foreign_key: true
      t.references :library, null: false, foreign_key: true

      t.timestamps
    end
  end
end
