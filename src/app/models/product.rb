class Product
  include Mongoid::Document
  include Mongoid::Paperclip
  field :product_name, :type => String
  field :views, :type => Integer, :default => 0
  field :added_date, :type => Time
  field :avg_rating, :type => Float, :default => -1
  field :price, :type => Float, :default => 0
  field :specs, :type => String
  field :synopsis, :type => String
  field :location, :type => String
  field :rent, :type => Float, :default => 0
  field :rank, :type => Integer

  has_mongoid_attached_file :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_uniqueness_of :product_name, :allow_nil => false
  field :_id, type: String, default: ->{ product_name }
  embedded_in :subcategory, :inverse_of => :product
  embeds_many :reviews
end
