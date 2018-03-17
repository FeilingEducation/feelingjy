class Review < ApplicationRecord
	belongs_to :user
	belongs_to :consult_transaction

	def avg_rate
		return (service_communication_rating+attitude_rating+efficiency_rating+authenticity_rating+cost_effectiveness_rating).to_f/5
	end

	def reviewer_name
		User.find(self.reviewer_id).user_info.full_name
	end

	def reviewer_image
		User.find(self.reviewer_id).user_info.avatar.url
	end
end
