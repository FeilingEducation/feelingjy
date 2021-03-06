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

  has_many :consult_transactions, foreign_key: 'student_id', dependent: :destroy
  has_many :instructors, through: 'consult_transactions', dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :sent_messages, class_name: :Message, foreign_key: :sender_id, dependent: :destroy
  has_many :received_messages, class_name: :Message, foreign_key: :receiver_id, dependent: :destroy

  delegate :email, to: :user

  validates_presence_of :id

  validates :first_name, :presence => true,
                         :length => { :maximum => 20 }
  validates :last_name, :presence => true,
                        :length => { :maximum => 20 }

  def full_name
    (self.last_name || '') + (self.first_name || '')
  end

  # implemented for "attachable" object so that we can check if a user is authorized
  # to modify an attachment, which contains no user information (attachable is the owner)
  def authorized_by(user)
    user.id == self.id
  end

end
