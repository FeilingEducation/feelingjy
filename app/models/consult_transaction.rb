class ConsultTransaction < ApplicationRecord

  enum status: {
    initiated: 0,
    confirmed: 1,
    canceled: 2,
    completed: 3,
    aborted: 4
  }

  belongs_to :instructor, class_name: 'instructor_info'
  belongs_to :student, class_name: 'user_info'

  validates_presence_of :instructor_id
  validates_presence_of :student_id
  validates :disallow_self_consult

  private

  def disallow_self_consult
    errors.add(:base, "Consulting yourself is not allowed") if :instructor_id == :student_id
  end
end
