class Latest
	include Mongoid::Document

	field :count, :type => Integer, :default => 0
	embeds_many :latestproducts #, order: :added_date.desc
	index "latestproducts.product_name" => 1
end

class Latestproduct
	include Mongoid::Document
	include Mongoid::Paperclip
	include Mongoid::Search
	
	field :product_name, :type => String
	field :added_date, :type =>Time
	has_mongoid_attached_file :image
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  	validates_uniqueness_of :product_name, :allow_nil => false
	field :views, :type => Integer, :default => 0
	field :avg_rating, :type => Float, :default => -1
	embedded_in :latest, :inverse_of => :latestproduct
	search_in :product_name
end