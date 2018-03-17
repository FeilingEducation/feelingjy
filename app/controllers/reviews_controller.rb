class ReviewsController < ApplicationController
	def index
		@tutor = User.find(params[:user_id])
	end

	def create
		@tutor = User.find(params[:user_id])
		@new_tutor_review = @tutor.reviews.create(review_params)
		redirect_to user_reviews_path(params[:user_id]), notice: "Review posted successfully."
	end

	private
	def review_params
		params.require(:review).permit(:service_communication, :attitude, :efficiency, :authenticity, :cost_effectiveness, 
			:reviewer_id, :service_communication_rating, :attitude_rating, :efficiency_rating, :authenticity_rating, :cost_effectiveness_rating,)
	end
end
