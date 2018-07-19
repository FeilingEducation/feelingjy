class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :user_info, foreign_key: "id"
  has_one :user_wallet
  has_many :reviews, dependent: :destroy

  delegate :total_withdrawl, :total_earned, :total_pending, :total_balance, to: :user_wallet

  after_create :create_user_wallet

  def create_user_wallet
    UserWallet.create(user_id: self.id)
  end

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
      if !r.service_communication_rating.nil?
        service = r.service_communication_rating
      end

      if !r.attitude_rating.nil?
        attitude = r.attitude_rating
      end

      if !r.efficiency_rating.nil?
        efficiency = r.efficiency_rating
      end

      if !r.authenticity_rating.nil?
        authenticity = r.authenticity_rating
      end

      if !r.cost_effectiveness_rating.nil?
        cost_effectiveness = r.cost_effectiveness_rating
      end
      i = i + 1
  		rating = (service + attitude + efficiency + authenticity + cost_effectiveness).to_f/5
      final_rating = final_rating + rating;
  	end
    if i == 0
      final_rating = 0
    else
      final_rating = final_rating/i;
    end
  	return final_rating
  end

  def get_service_rating
    final_service_rating = 0
    i = 0
    self.reviews.each do |r|
      service = 0
      if !r.service_communication_rating.nil?
        service = r.service_communication_rating
      end
      i = i + 1
      final_service_rating = final_service_rating + service
    end
    if i == 0
      final_service_rating = 0
    else
      final_service_rating = 20*final_service_rating/i;
    end
    return final_service_rating.to_f
  end

  def get_attitude_rating
    final_attitude_rating = 0
    i = 0
    self.reviews.each do |r|
      attitude = 0
      if !r.attitude_rating.nil?
        attitude = r.attitude_rating
      end
      i = i + 1
      final_attitude_rating = final_attitude_rating + attitude
    end
    if i == 0
      final_attitude_rating = 0
    else
      final_attitude_rating = 20*final_attitude_rating/i;
    end
    return final_attitude_rating.to_f
  end

  def get_efficiency_rating
    final_efficiency_rating = 0
    i = 0
    self.reviews.each do |r|
      efficiency = 0
      if !r.efficiency_rating.nil?
        efficiency = r.efficiency_rating
      end
      i = i + 1
      final_efficiency_rating = final_efficiency_rating + efficiency
    end
    if i == 0
      final_efficiency_rating = 0
    else
      final_efficiency_rating = 20*final_efficiency_rating/i;
    end
    return final_efficiency_rating.to_f
  end

  def get_authenticity_rating
    final_authenticity_rating = 0
    i = 0
    self.reviews.each do |r|
      authenticity = 0
      if !r.authenticity_rating.nil?
        authenticity = r.authenticity_rating
      end
      i = i + 1
      final_authenticity_rating = final_authenticity_rating + authenticity
    end
    if i == 0
      final_authenticity_rating = 0
    else
      final_authenticity_rating = 20*final_authenticity_rating/i;
    end
    return final_authenticity_rating.to_f
  end

  def get_cost_effectiveness_rating
    final_cost_effectiveness_rating = 0
    i = 0
    self.reviews.each do |r|
      cost_effectiveness = 0
      if !r.cost_effectiveness_rating.nil?
        cost_effectiveness = r.cost_effectiveness_rating
      end
      i = i + 1
      final_cost_effectiveness_rating = final_cost_effectiveness_rating + cost_effectiveness
    end

    if i == 0
      final_cost_effectiveness_rating = 0
    else
      final_cost_effectiveness_rating = 20*final_cost_effectiveness_rating/i;
    end
    return final_cost_effectiveness_rating.to_f
  end


end
