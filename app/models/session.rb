class Session < ApplicationRecord
  belongs_to :user

  def self.sweep(time = 1.hour)
    where(updated_at: ...time.ago).delete_all
  end
  
end
