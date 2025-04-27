class ReviewsController < ApplicationController
    before_action :authenticate_user!
    def index
        reviews = Review.where(product_id: review_params[:product_id])
        render json: reviews
    end
    def create
        review= Review.new(review_params)
        review.user_id = current_user.id
        if review.save
            render json: {message: "Review created"}, status: :created
        else
           render json: {message: "Review not created"}, status: :unprocessable_entity
        end
    end
    def deleted 
        review= Review.find(params[:id])
        review.destroy
        redirect_to request.referer
    end
    private
    def review_params
        params.require(:review).permit(:comment, :start, :product_id)
    end

end
