class InstructorInfo < ApplicationRecord

  belongs_to :user_info, :foreign_key => :id
  delegate :first_name, :last_name, :full_name, :gender, :avatar, :phone_number, :user_documents, to: 'user_info'

  has_many :consult_transactions, foreign_key: 'instructor_id'
  has_many :students, through: 'consult_transactions'
  has_many :private_policies, foreign_key: 'instructor_id'

  mount_uploader :page_background, PageBackgroundUploader

  validates_presence_of :id, on: [:create]

  def resumes
    self.user_documents.where(doc_type: 'resume')
  end

end
