class UserInfo < ApplicationRecord

  enum gender: { male: 0, female: 1, other: 2 }

  mount_uploader :avatar, AvatarUploader

  belongs_to :user, foreign_key: 'id'
  has_one :instructor_info, foreign_key: 'id'
  has_many :consult_transactions, foreign_key: 'student_id'
  has_many :instructors, through: 'consult_transactions'

  validates_presence_of :id
  validates_presence_of :gender

  validates :first_name, :presence => true,
                         :length => { :maximum => 20 }
  validates :last_name, :presence => true,
                        :length => { :maximum => 20 }

end
