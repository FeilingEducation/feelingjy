class InstructorInfo < ApplicationRecord

  belongs_to :user_info, foreign_key: 'id'

  validates_presence_of :id

end
