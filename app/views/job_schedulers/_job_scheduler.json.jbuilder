json.extract! job_scheduler, :id, :name, :description, :submission_rule, :created_at, :updated_at
json.url job_scheduler_url(job_scheduler, format: :json)
