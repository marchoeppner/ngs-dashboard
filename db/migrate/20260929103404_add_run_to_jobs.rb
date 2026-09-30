class AddRunToJobs < ActiveRecord::Migration[8.1]
  def change
    add_reference :jobs, :run, null: false, foreign_key: true
  end
end
