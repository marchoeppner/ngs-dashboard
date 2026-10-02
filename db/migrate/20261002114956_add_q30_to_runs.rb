class AddQ30ToRuns < ActiveRecord::Migration[8.1]
  def change
    add_column :runs, :qc_json, :jsonb
  end
end
