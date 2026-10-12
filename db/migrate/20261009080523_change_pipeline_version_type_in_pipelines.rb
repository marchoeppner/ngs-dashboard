class ChangePipelineVersionTypeInPipelines < ActiveRecord::Migration[8.1]
  def change
    change_column :pipelines, :version, :text
  end
end
