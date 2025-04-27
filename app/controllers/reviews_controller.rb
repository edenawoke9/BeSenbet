class ReviewsController < ApplicationController
    before_action :authenticate_user!
    def create
        review= Review.new(review_params)
        review.user_id = current_user.id
        review.product_id = params[:product_id]
        review.save
        redirect_to request.referer
    end
    def deleted 
        review= Review.find(params[:id])
        review.destroy
        redirect_to request.referer
    end
    private
    def review_params
        params.require(:review).permit(:content, :rating)
    end

end
