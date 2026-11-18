json.extract! instrument, :id, :name, :nickname, :nfs_path, :platform, :created_at, :updated_at
json.url instrument_url(instrument, format: :json)
