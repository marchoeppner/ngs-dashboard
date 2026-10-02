class Pipeline < ApplicationRecord
    has_many :jobs

    def clean_name
      self.name.gsub(" ", "_")
    end
end
