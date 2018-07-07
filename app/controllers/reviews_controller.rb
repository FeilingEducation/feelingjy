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

	def new
		@transaction = ConsultTransaction.find params[:consult_transaction_id]
		@review = Review.new consult_transaction_id: @transaction.id
	end

	def create
		@transaction = ConsultTransaction.find params[:consult_transaction_id]
		if @transaction.status == "reviewed"
			redirect_to root_url, alert: I18n.t("flash_notice.transaction.has_reviewed")
		else
			@tutor = @transaction.instructor.user_info.user
			@reviewer = current_user
			status = @transaction.status


			# student reviewing tutor
			unless current_user.id == @tutor.id
				@tutor = @transaction.student.user
				status = @transaction.status == "instructor_reviewed" ? :reviewed : :student_reviewed
			else
				# student reviewing instructor.
				status = @transaction.status == "student_reviewed" ? :reviewed : :instructor_reviewed
			end

			@tutor_review = @tutor.reviews.new(review_params)
			@tutor_review.reviewer = @reviewer
			@tutor_review.consult_transaction = @transaction
			@tutor_review.save
			@transaction.update!(status: status)
			flash[:notice] = I18n.t("flash_notice.transaction.transaction_reviewed")
			redirect_to consult_transactions_path
			# else
			# 	flash[:notice] = I18n.t("flash_notice.transaction.transaction_review_failed")
			# 	render 'index'
			# end
		end
		# redirect_to user_reviews_path(params[:user_id], transaction_id: params[:review][:consult_transaction_id]), notice: "Review posted successfully."
	end

	private
	def review_params
		params.require(:review).permit(:review_text, :reviewer_id, :service_communication_rating, :attitude_rating, :efficiency_rating, :authenticity_rating, :cost_effectiveness_rating,:consult_transaction_id)
	end
end
