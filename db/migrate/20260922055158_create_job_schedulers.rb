class CreateJobSchedulers < ActiveRecord::Migration[8.1]
  def change
    create_table :job_schedulers do |t|
      t.string :name
      t.string :description
      t.string :submission_rule

      t.timestamps
    end
  end
end
