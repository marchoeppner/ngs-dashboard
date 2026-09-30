class AddDependsOnToJobs < ActiveRecord::Migration[8.1]
  def change
    add_column :jobs, :depends_on, :integer
  end
end
