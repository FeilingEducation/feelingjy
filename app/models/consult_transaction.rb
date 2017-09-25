class ConsultTransaction < ApplicationRecord

  after_create :build_chat

  enum status: {
    initiated: 0,
    payment_pending: 1,
    confirmed: 2,
    canceled: 3,
    completed: 4,
    aborted: 5
  }

  belongs_to :instructor, class_name: 'InstructorInfo'
  belongs_to :student, class_name: 'UserInfo'

  has_one :chat

  validates_presence_of :instructor_id
  validates_presence_of :student_id
  validate do
    errors.add(:base, "Consulting yourself is not allowed") if instructor_id == student_id
  end

  private

  def build_chat
    Chat.create([consult_transaction_id: self.id])
  end

end
