require "sentimentalizer"
class CategoriesController < ApplicationController
	def index
	@categories = Category.all
	Sentimentalizer.analyze('i am so happy')
	end

	def show
	@category=Category.find(params[:id])
	@time = @category.last_modified
	end

	def new
	@category = Category.new
	end

	def create
	
	if(Category.all.count==0)
		@latest = Latest.new
		@latest.save
	end
	
	@category = Category.new(post_params)
	@category.last_modified = Time.now.utc

	if(@category.save)
		redirect_to categories_path
	end

	end

	def addsubcategory
		@category=Category.find(params[:category_id])
	end

	def self.order(type)
    	super(type.asc)
	end

	def post_params
	params.require(:category).permit(:category_id,:category_name)
  	end

end
