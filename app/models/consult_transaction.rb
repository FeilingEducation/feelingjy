class ConsultTransaction < ApplicationRecord

  enum status: {
    initiated: 0,
    modified: 1,
    confirmed: 2,
    canceled: 3,
    completed: 4,
    aborted: 5
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
