class InstructorInfo < ApplicationRecord

  belongs_to :user_info, :foreign_key => :id

  has_many :consult_transactions, foreign_key: 'instructor_id'
  has_many :students, through: 'consult_transactions'

  validates_presence_of :id

end
