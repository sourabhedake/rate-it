class SubcategoriesController < ApplicationController
	helper_method :onclickevent
	def create
	@category=Category.find(params[:category_id])
	@subcategory=@category.subcategories.new(post_params)
	@subcategory.last_modified=Time.now.utc.iso8601
	
	if(@subcategory.save)
		redirect_to @category
	end

	end

	def show
		@category = Category.where("subcategories._id"=>params[:id]).one
		@subcategory = @category.subcategories.find(params[:id])
	end

	def post_params
		params.require(:subcategory).permit(:subcategory_name)
	end

	def addproduct
		#@category = Category.find(params[:category_id])
		#@subcategory = @category.subcategories.find(params[:subcategory])
	end

	def index

	end

	def onclickevent()
		
	end

end
