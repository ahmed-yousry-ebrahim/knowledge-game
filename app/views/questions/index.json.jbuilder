json.array!(@questions) do |question|
  json.extract! question, :id, :title, :option1, :option2, :option3, :option4
  json.url question_url(question, format: :json)
end
