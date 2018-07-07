class Review < ApplicationRecord
	belongs_to :user
	belongs_to :reviewer, class_name: "User"
	
	belongs_to :consult_transaction

	def avg_rate
		service = 0
		attitude = 0
		efficiency = 0
		authenticity = 0
		cost_effectiveness = 0
		if !service_communication_rating.nil?
			service = service_communication_rating
		end

		if !attitude_rating.nil?
			attitude = attitude_rating
		end

		if !efficiency_rating.nil?
			efficiency = efficiency_rating
		end

		if !authenticity_rating.nil?
			authenticity = authenticity_rating
		end
		if !cost_effectiveness_rating.nil?
			cost_effectiveness = cost_effectiveness_rating
		end

		return rating = (service + attitude + efficiency + authenticity + cost_effectiveness).to_f/5
	end

	def reviewer_name
		User.find(self.reviewer_id).user_info.full_name
	end

	def reviewer_image
		User.find(self.reviewer_id).user_info.avatar.url
	end

	def reviewer_location
    User.find(self.reviewer_id).user_info.current_city
	end
end
