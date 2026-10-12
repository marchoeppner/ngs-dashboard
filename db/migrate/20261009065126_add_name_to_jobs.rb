class AddNameToJobs < ActiveRecord::Migration[8.1]
  def change
    add_column :jobs, :name, :string
  end
end
