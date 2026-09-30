class Library < ApplicationRecord
  belongs_to :platform
  belongs_to :run
  has_many :xref_job_libraries
  has_many :jobs, through: :xref_job_libraries
end
