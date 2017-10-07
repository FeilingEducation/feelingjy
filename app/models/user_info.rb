class UserInfo < ApplicationRecord

  enum gender: { male: 0, female: 1, other: 2 }
  enum program_year: {
    graduated: -1,
    admitted: 0,
    freshman: 1,
    sophomore: 2,
    junior: 3,
    senior: 4,
    fifth_or_above: 5
  }

  mount_uploader :avatar, AvatarUploader

  belongs_to :user, foreign_key: 'id'
  has_one :instructor_info, foreign_key: 'id'

  has_many :consult_transactions, foreign_key: 'student_id'
  has_many :instructors, through: 'consult_transactions'
  has_many :attachments, as: :attachable
  has_many :sent_messages, class_name: :Message, foreign_key: :sender_id
  has_many :received_messages, class_name: :Message, foreign_key: :receiver_id

  validates_presence_of :id

  validates :first_name, :presence => true,
                         :length => { :maximum => 20 }
  validates :last_name, :presence => true,
                        :length => { :maximum => 20 }

  def full_name
    self[:last_name] + self[:first_name]
  end

  def authorized_by(user)
    user.id == self.id
  end

end
