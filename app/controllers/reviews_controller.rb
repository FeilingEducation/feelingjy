class ReviewsController < ApplicationController
	def index
		@transaction = ConsultTransaction.find(params[:transaction_id])
		@tutor = User.find(params[:user_id])
		@tutor_review = @transaction.review.nil? ? @tutor.reviews.new : @transaction.review
	end

	def create
		@tutor = User.find(params[:user_id])
		@new_tutor_review = @tutor.reviews.create(review_params)
		redirect_to user_reviews_path(params[:user_id], transaction_id: params[:review][:consult_transaction_id]), notice: "Review posted successfully."
	end

	private
	def review_params
		params.require(:review).permit(:review_text, :reviewer_id, :service_communication_rating, :attitude_rating, :efficiency_rating, :authenticity_rating, :cost_effectiveness_rating,:consult_transaction_id)
	end
end
