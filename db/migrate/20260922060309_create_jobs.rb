class CreateJobs < ActiveRecord::Migration[8.1]
  def change
    create_table :jobs do |t|
      t.integer :job_id
      t.string :status
      t.boolean :completed
      t.integer :attempts
      t.date :completed_at
      t.string :run_path
      t.string :log

      t.timestamps
    end
  end
end
