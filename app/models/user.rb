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
  	self.reviews.each do |r|
  		rating = (r.service_communication_rating+r.attitude_rating+r.efficiency_rating+r.authenticity_rating+r.cost_effectiveness_rating).to_f/5
  	end
  	return rating
  end
end
