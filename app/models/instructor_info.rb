class InstructorInfo < ApplicationRecord

  belongs_to :user_info, :foreign_key => :id
  # delegate some fields to the UserInfo, which might incurr extra BD lookup
  delegate :first_name, :last_name, :full_name, :gender, :avatar, :phone_number, :attachments, to: 'user_info'

  has_many :consult_transactions, foreign_key: 'instructor_id'
  has_many :students, through: 'consult_transactions'
  has_many :private_policies, foreign_key: 'instructor_id'

  # TODO: maybe unify it with a more general uploader
  mount_uploader :page_background, PageBackgroundUploader

  validates_presence_of :id, on: [:create]

  UNIVERSITIES_ENGLISH = ["California Institute of Technology (Caltech)", "Cambridge", "Columbia University", "Cornell University", "Harvard University", "Johns Hopkins University", "Massachusetts Institute of Technology (MIT)", "Princeton University", "Stanford University", "University of Chicago", "Yale University"]
  UNIVERSITIES_CHINESE = ["California Institute of Technology (Caltech)", "Cambridge", "Columbia University", "Cornell University", "Harvard University", "Johns Hopkins University", "Massachusetts Institute of Technology (MIT)", "Princeton University", "Stanford University", "University of Chicago", "Yale University"]
  SPECIALIZATIONS_ENGLISH = ["Arts & Humanities", "Biological Sciences", "Business", "Computer Science", "Engineering", "English Literature", "Management", "Mathematics", "Physics"]
  SPECIALIZATIONS_CHINESE = ["Arts & Humanities", "Biological Sciences", "Business", "Computer Science", "Engineering", "English Literature", "Management", "Mathematics", "Physics"]
  DEGREE_COMPLETED_ENGLISH = ['First year graduate student','Second year graduate student', 'Third year graduate student', 'Final year graduate student', 'Complete Degree']
  DEGREE_COMPLETED_CHINESE = ['First year graduate student','Second year graduate student', 'Third year graduate student', 'Final year graduate student', 'Complete Degree']

  TUTOR_OPTIONS_ENGLISH = ['Yes, I can do this', 'No, I can\'t do this']
  TUTOR_OPTIONS_CHINES = ['Yes, I can do this', 'No, I can\'t do this']

  def resumes
    self.attachments.where(file_type: 'resume')
  end

  def self.universities_as_optons local='en'
    (local == 'en' ? UNIVERSITIES_ENGLISH : UNIVERSITIES_CHINESE).each_with_index.map {|m,i| [m,i]}
  end

  def self.spcializations_as_optons local='en'
    (local == 'en' ? SPECIALIZATIONS_ENGLISH : SPECIALIZATIONS_CHINESE).each_with_index.map {|m,i| [m,i]}
  end

  def self.degree_as_optons local='en'
    (local == 'en' ? DEGREE_COMPLETED_ENGLISH : DEGREE_COMPLETED_CHINESE).each_with_index.map {|m,i| [m,i]}
  end

  def self.tutor_options local='en'
    (local == 'en' ? TUTOR_OPTIONS_ENGLISH : TUTOR_OPTIONS_CHINES).each_with_index.map {|m,i| [m,i]}
  end
end
