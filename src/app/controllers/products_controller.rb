class ProductsController < ApplicationController
	def create
		Rails.logger.debug params.inspect
		@category = Category.where("subcategories._id"=>params[:subcategory_id]).one
		@subcategory=@category.subcategories.find(params[:subcategory_id])
		@product=@subcategory.products.new(post_params)

		@product.added_date = Time.now.utc.iso8601
		@subcategory.last_modified = Time.now.utc.iso8601
		@category.last_modified = Time.now.utc.iso8601


		@latest = Latest.all.one
		@latest.count = @latest.count+1
		@lproduct=@latest.latestproducts.new
		@lproduct.product_name=@product.product_name
		@lproduct.added_date=@product.added_date
		@lproduct.image=@product.image
		
		@category.save
		@product.save
		@latest.save
		@lproduct.save
		redirect_to @subcategory
	end

	def new
	@product = Product.new
	end

	def post_params
		params.require(:product).permit(:product_id,:product_name,:image,:price,:specs,:synopsis,:location,:rent,:rank)
	end

	def show
		Rails.logger.debug params.inspect
		@category = Category.where("subcategories.products._id"=>params[:id]).one
		@subcategory = @category.subcategories.where("products._id"=> params[:id]).one
		@product = Category.where("subcategories.products._id"=>params[:id]).one.subcategories.where("products._id"=> params[:id]).one.products.find(params[:id])
		
		@product.views=@product.views+1
		@latest=Latest.one.latestproducts.where("product_name" => params[:id]).one
		
		@latest.views=@product.views		
		
		@product.save
		@latest.save
		#@subcategories = @category.subcategories.all
	end

	def destroy
		redirect_to root_path
	end
	
	def index
	end
end
