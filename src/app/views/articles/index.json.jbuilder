json.array!(@articles) do |article|
  json.extract! article, :id, :art_id, :art_name
  json.url article_url(article, format: :json)
end
