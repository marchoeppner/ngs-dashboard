class ChangeColumnVersionInPipeline < ActiveRecord::Migration[8.1]
  def change
    change_column :pipelines, :version, :float
  end
end
