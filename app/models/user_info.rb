class UserInfo < ApplicationRecord

  belongs_to :user, foreign_key: 'id'

  GENDERS = ['', 'male', 'female', 'other']

  validates_presence_of :id

  validates :first_name, :presence => true,
                         :length => { :maximum => 20 }
  validates :last_name, :presence => true,
                        :length => { :maximum => 20 }
  validates :gender, :inclusion => { in: GENDERS }

end
