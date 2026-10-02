class AddReportToJobs < ActiveRecord::Migration[8.1]
  def change
    add_column :jobs, :report, :text
  end
end
