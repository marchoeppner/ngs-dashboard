class XrefJobLibrary < ApplicationRecord
  belongs_to :job
  belongs_to :library
end
