class Review < ApplicationRecord
	belongs_to :user
	belongs_to :reviewer, class_name: "User"

	belongs_to :consult_transaction
	after_create :set_user_rating

	def avg_rate
		services = [service_communication_rating, attitude_rating, efficiency_rating, authenticity_rating, cost_effectiveness_rating].reject{|a| a.nil? }
		services.sum.to_f / services.size
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

	def set_user_rating
		# TODO
		# Should be done via following query but it returns integer value instead of float
		# user.reviews.select("AVG(CAST(attitude_rating as float)) as attitude_rating",
		# "AVG(CAST(cost_effectiveness_rating as float)) as cost_effectiveness_rating",
		# "AVG(CAST(authenticity_rating as float)) as authenticity_rating",
		# "AVG(CAST(efficiency_rating as float)) as efficiency_rating",
		# "AVG(CAST(service_communication_rating as float)) as service_communication_rating")
		average = []
		average.push user.reviews.average(:attitude_rating)
		average.push user.reviews.average(:cost_effectiveness_rating)
		average.push user.reviews.average(:authenticity_rating)
		average.push user.reviews.average(:efficiency_rating)
		average.push user.reviews.average(:service_communication_rating)

		average.reject! {|a| a == 0}

		user.update(rating: average.inject(:+).to_f / average.size)

	end
end
