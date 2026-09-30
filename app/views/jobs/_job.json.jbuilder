json.extract! job, :id, :job_id, :status, :completed, :attempts, :completed_at, :run_path, :log, :created_at, :updated_at
json.url job_url(job, format: :json)
