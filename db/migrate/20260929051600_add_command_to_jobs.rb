class AddCommandToJobs < ActiveRecord::Migration[8.1]
  def change
    add_column :jobs, :command, :string
  end
end
