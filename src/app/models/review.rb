class Review
  include Mongoid::Document
  field :email, :type => String
  validates_uniqueness_of :email, :allow_nil => false
  field :product_name
  field :body
  field :review_date, :type => Time
  field :rating, :type => Float
  embedded_in :product, :inverse_of => :review
end
