json.extract! pipeline, :id, :name, :version, :template, :description, :run_level, :samplesheet_format, :job_level, :created_at, :updated_at
json.url pipeline_url(pipeline, format: :json)
