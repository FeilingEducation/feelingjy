class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :user_info, foreign_key: "id"
  has_many :reviews

  def name
    email
  end

  def get_rating
  	rating = 0
    final_rating = 0
    i = 0
  	self.reviews.each do |r|
      service = 0
      attitude = 0
      efficiency = 0
      authenticity = 0
      cost_effectiveness = 0
      if r.service_communication_rating.nil?
        service = 0
      else
        service = r.service_communication_rating
      end

      if r.attitude_rating.nil?
        attitude = 0
      else
        attitude = r.attitude_rating
      end

      if r.efficiency_rating.nil?
        efficiency = 0
      else
        efficiency = r.efficiency_rating
      end

      if r.authenticity_rating.nil?
        authenticity = 0
      else
        authenticity = r.authenticity_rating
      end

      if r.cost_effectiveness_rating.nil?
        cost_effectiveness = 0
      else
        cost_effectiveness = r.cost_effectiveness_rating
      end
      i = i + 1
  		rating = (service + attitude + efficiency + authenticity + cost_effectiveness).to_f/5
      final_rating = (final_rating + rating)/i;
  	end
  	return final_rating
  end
end
