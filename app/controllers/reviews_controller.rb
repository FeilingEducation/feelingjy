class ReviewsController < ApplicationController
	def index
		@transaction = ConsultTransaction.find(params[:transaction_id])
		if @transaction.student_id == current_user.id
			if @transaction.status == "completed"
				@tutor = User.find(params[:user_id])
				@tutor_review = @transaction.review.nil? ? @tutor.reviews.new : @transaction.review
			else
				redirect_to root_url, alert: I18n.t("flash_notice.transaction.review_denied")
			end
		else
			redirect_to root_url, alert: I18n.t("flash_notice.transaction.review_denied")
		end
	end

	def create
		@transaction = ConsultTransaction.find(params[:review][:transaction_id])
		@tutor = User.find(params[:user_id])
		if @transaction.status == "reviewed"
			redirect_to root_url, alert: I18n.t("flash_notice.transaction.has_reviewed")
		else
			@new_tutor_review = @tutor.reviews.create(review_params)
			if @transaction.update(status: :reviewed)
				flash[:notice] = I18n.t("flash_notice.transaction.transaction_reviewed")
				redirect_to @transaction
			else
				flash[:notice] = I18n.t("flash_notice.transaction.transaction_review_failed")
				render 'index'
			end
		end
		# redirect_to user_reviews_path(params[:user_id], transaction_id: params[:review][:consult_transaction_id]), notice: "Review posted successfully."

	end

	private
	def review_params
		params.require(:review).permit(:review_text, :reviewer_id, :service_communication_rating, :attitude_rating, :efficiency_rating, :authenticity_rating, :cost_effectiveness_rating,:consult_transaction_id)
	end
end
