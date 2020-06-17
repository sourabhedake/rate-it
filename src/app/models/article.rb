class Article
  include Mongoid::Document
  field :art_id, type: Integer
  field :art_name, type: String
end
