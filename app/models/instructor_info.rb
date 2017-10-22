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

  SCHOOLS_APPLIED_BEFORE_ENGLISH = ['One', 'Two','Three', 'Four', 'Five or more']
  SCHOOLS_APPLIED_BEFORE_CHINESE = ['1所学校', '2所学校','3所学校', '4所学校', '全部录取']

  TUTOR_BEFORE_ENGLISH = ['I am a newcomer', 'I have few years of experience','I am a tutor by profession']
  TUTOR_BEFORE_CHINESE = ['1所学校', '2所学校','3所学校', '4所学校', '全部录取']

  MAX_STUDENTS_ENGLISH = ['I want to focus on one student', 'I can work with two students','I can work with three students', 'I can manage 5+ students']
  MAX_STUDENTS_CHINESE = ['1所学校', '2所学校','3所学校', '4所学校', '全部录取']

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

  def self.schools_applied_before_options local='en'
    (local == 'en' ? SCHOOLS_APPLIED_BEFORE_ENGLISH : SCHOOLS_APPLIED_BEFORE_CHINESE).each_with_index.map {|m,i| [m,i]}
  end

  def self.tutor_before_options local='en'
    (local == 'en' ? TUTOR_BEFORE_ENGLISH : TUTOR_BEFORE_CHINESE).each_with_index.map {|m,i| [m,i]}
  end

  def self.max_std_before_options local='en'
    (local == 'en' ? MAX_STUDENTS_ENGLISH : MAX_STUDENTS_CHINESE).each_with_index.map {|m,i| [m,i]}
  end

  def self.countries_as_options
    CS.countries.map {|key, val| [val, key]}
  end

  def self.default_states_as_options
    CS.states(:CN).map {|key, val| [val, key]}
  end

  def self.default_cities_as_options
    CS.cities(:"11", :CN)
  end
end
