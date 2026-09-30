class AddPipelineToJobs < ActiveRecord::Migration[8.1]
  def change
    add_reference :jobs, :pipeline, null: false, foreign_key: true
  end
end
