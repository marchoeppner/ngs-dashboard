class Job < ApplicationRecord
    has_many :xref_job_libraries, dependent: :destroy
    has_many :libraries, through: :xref_job_libraries
    belongs_to :run
    belongs_to :pipeline
    belongs_to :user

    paginates_per 25
end
