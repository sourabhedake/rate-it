require "sentimentalizer"
class ReviewsController < ApplicationController
	def create
		@category=Category.where("subcategories.products._id"=>params[:product_id]).one
		@subcategory = @category.subcategories.where("products._id"=>params[:product_id]).one
		@product=@subcategory.products.find(params[:product_id])
		@review=@product.reviews.new(post_params)
		@review.product_name=params[:product_id]
		@review.review_date = Time.now.utc.iso8601
		@review.email=current_user.email
		
		@probability=Sentimentalizer.analyze(@review.body,true).split(':')[2].split(',')[0]
		@review.rating = ((@probability.to_f)*10).round(1)

		@avg_rating = 0;
		for review in @product.reviews
			@avg_rating = @avg_rating+review.rating
		end

		@avg_rating = @avg_rating/(@product.reviews.count+1)
		@product.avg_rating = @avg_rating
		@latest = Latest.last.latestproducts.where("product_name"=>@product.product_name).one
		@latest.avg_rating = @avg_rating
		@product.save
		@latest.save
		if(@review.save)
			redirect_to @product
		end

	end

	def post_params
		params.require(:review).permit(:email,:product_name,:body)
	end

	def update
		@product = Category.where("subcategories.products._id"=>params[:product_name]).one.subcategories.where("products._id"=> params[:product_name]).one.products.find(params[:product_name])

		#@product=Category.one.subcategories.where("products.product_name"=>params[:product_name]).one.products.find(params[:product_name])
		@reviews = @product.reviews


		for review in @reviews
			if review.email==current_user.email
				review.body=params[:review][:body]
				@product.avg_rating = ((@product.avg_rating * @product.reviews.count)-review.rating) 

				@probability=Sentimentalizer.analyze(review.body,true).split(':')[2].split(',')[0]
				review.rating = ((@probability.to_f)*10).round(1)
				review.save
				break
			end
		end
		@product.avg_rating = (@product.avg_rating+((@probability.to_f)*10).round(1))/@product.reviews.count 
		@product.save
		redirect_to @product


	end


end
