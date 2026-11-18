class AddPlatformIdToInstruments < ActiveRecord::Migration[8.1]
  def change
    add_reference :instruments, :platform, null: false, foreign_key: true
  end
end
