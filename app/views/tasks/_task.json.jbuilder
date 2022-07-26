json.extract! task, :id, :done, :title, :created_at, :updated_at
json.url task_url(task, format: :json)
