class InstructorInfo < ApplicationRecord

  belongs_to :user_info, :foreign_key => :id
  # delegate some fields to the UserInfo, which might incurr extra BD lookup
  delegate :first_name, :last_name, :full_name, :gender, :avatar, :phone_number, :attachments, :email, to: 'user_info'

  has_many :consult_transactions, foreign_key: 'instructor_id'
  has_many :students, through: 'consult_transactions'
  has_many :private_policies, foreign_key: 'instructor_id'

  attr_accessor :avatar_cache

  # TODO: maybe unify it with a more general uploader
  mount_uploader :page_background, PageBackgroundUploader

  validates_presence_of :id, on: [:create]

  UNIVERSITIES_ENGLISH = ["Brown University","California Institute of Technology (Caltech)","Columbia University","Cornell University","Dartmouth College","Duke University","Emory University","Georgetown University","Harvard University","Johns Hopkins University","Massachusetts Institute of Technology (MIT)","Northwestern University","Princeton University","Rice University","Stanford University","UC Berkeley","UCLA","University of Chicago","University of Notre Dame", "University of Pennsylvania", "University of Southern California", "University of Virginia", "University of Wisconsin-Madison","Vanderbilt University","Washington University in St. Louis","Yale University"]
  UNIVERSITIES_CHINESE = ['布朗大学','加州理工学院','哥伦比亚大学','康奈尔大学','达特茅斯学院','杜克大学','埃默里大学','乔治城大学','哈佛大学','约翰霍普金斯大学','麻省理工学院','西北大学','普林斯顿大学','莱斯大学','斯坦福大学','加州大学伯克利分校','加州大学洛杉矶分校','芝加哥大学','圣母大学','宾夕法尼亚大学','南加州大学','弗吉尼亚大学','威斯康辛大学麦迪逊分校','范德堡大学','圣路易斯华盛顿大学','耶鲁大学']

  SPECIALIZATIONS_ENGLISH = ["Arts & Humanities", "Biological Sciences", "Business", "Computer Science", "Engineering", "Literature", "Law", "Management", "Mathematics", "Physics"]
  SPECIALIZATIONS_CHINESE = ["艺术与人文领域", "生命科学", "商科", "计算机科学", "工程", "文学", "法律", "管理", "数学", "物理"]

  DEGREE_COMPLETED_ENGLISH = ["Bachelor (junior)", "Bachelor (senior)", "First year graduate student", "Second year graduate student", "PhD","Bachelor (graduated)","Master (graduated)", "PhD (graduated)"]
  DEGREE_COMPLETED_CHINESE = ['在读本科第三年','在读本科第四年', '在读研究生第一年', '在读研究生第二年', '在读博士','本科（已毕业）','研究生（已毕业）','博士（已毕业）']

  TUTOR_OPTIONS_ENGLISH = ['Yes, I can do this', 'No, I can\'t do this']
  TUTOR_OPTIONS_CHINESE = ['是的,我能做这些', '抱歉,我做不了这些']

  SCHOOLS_APPLIED_BEFORE_ENGLISH = ['One', 'Two','Three', 'Four', 'Five or more']
  SCHOOLS_APPLIED_BEFORE_CHINESE = ['1所学校', '2所学校','3所学校', '4所学校', '5所学校或5所以上']

  TUTOR_BEFORE_ENGLISH = ['I am a newcomer', 'I have few years of experience','I am a tutor by profession']
  TUTOR_BEFORE_CHINESE = ['我是名新手', '我有几年的经验','我是专业的导师']

  MAX_STUDENTS_ENGLISH = ['I want to focus on one student', 'I can work with two students','I can work with three students', 'I can manage 5+ students']
  MAX_STUDENTS_CHINESE = ['我要专注,1名就够', '我可以同时和2个学生一起合作','我可以同时和3个学生一起合作', '我可以同时和超过5个学生一起合作']

  ADVANCE_NOTIFY_ENGLISH = ['At least one day', 'At least two days','At least three days', 'At least a week']
  ADVANCE_NOTIFY_CHINESE = ['至少一天前', '至少两天前','至少三天前', '至少一周前']

  RESERVE_ADVANCE_NOTIFY_ENGLISH = ['1 week ago', '2 weeks ago', '1 month ago','3 months ago', '6 months ago']
  RESERVE_ADVANCE_NOTIFY_CHINESE = ['一周前', '两周前','一个月前', '3个月前', '6个月前']

  WORK_FREQ_NOTIFY_ENGLISH = ['As less as possible', 'As much as possible']
  WORK_FREQ_NOTIFY_CHINESE = ['尽可能少', '尽可能多']

  BEST_APPLYING_AT_ENGLISH = ['Top 10 American Universities', 'Top 20 American Universities', 'Top 30 American Universities']
  BEST_APPLYING_AT_CHINESE = ['全美前10名大学', '全美前20名大学','全美前30名大学']


  def resumes
    self.attachments.where(file_type: 'resume')
  end

  def self.universities_as_optons local='en'
    puts "local::::::#{local}"
    puts "local.to_s == 'en':::::: #{local.to_s == 'en'}"
    puts "local.to_s == 'en':::: #{local.to_s == "en"}"
    (local.to_s == "en" ? UNIVERSITIES_ENGLISH : UNIVERSITIES_CHINESE).each_with_index.map {|m,i| [m,i]}
  end

  def self.spcializations_as_optons local='en'
    (local.to_s == 'en' ? SPECIALIZATIONS_ENGLISH : SPECIALIZATIONS_CHINESE).each_with_index.map {|m,i| [m,i]}
  end

  def self.degree_as_optons local='en'
    (local.to_s == 'en' ? DEGREE_COMPLETED_ENGLISH : DEGREE_COMPLETED_CHINESE).each_with_index.map {|m,i| [m,i]}
  end

  def self.tutor_options local='en'
    (local.to_s == 'en' ? TUTOR_OPTIONS_ENGLISH : TUTOR_OPTIONS_CHINESE).reverse.each_with_index.map {|m,i| [m,i.to_s]}
  end

  def self.schools_applied_before_options local='en'
    puts "============:::#{local}"
    (local.to_s == 'en' ? SCHOOLS_APPLIED_BEFORE_ENGLISH : SCHOOLS_APPLIED_BEFORE_CHINESE).each_with_index.map {|m,i| [m,i]}
  end

  def self.schoools_accepted local='en'
    (local.to_s == 'en' ? UNIVERSITIES_ENGLISH : UNIVERSITIES_CHINESE).each_with_index.map {|m,i| [m,i]}
  end

  def self.tutor_before_options local='en'
    (local.to_s == 'en' ? TUTOR_BEFORE_ENGLISH : TUTOR_BEFORE_CHINESE).each_with_index.map {|m,i| [m,i]}
  end

  def self.max_std_before_options local='en'
    (local.to_s == 'en' ? MAX_STUDENTS_ENGLISH : MAX_STUDENTS_CHINESE).each_with_index.map {|m,i| [m,i]}
  end

  def self.advance_notify_options local='en'
    (local.to_s == 'en' ? ADVANCE_NOTIFY_ENGLISH : ADVANCE_NOTIFY_CHINESE).each_with_index.map {|m,i| [m,i]}
  end

  def self.reserve_advance_notify_options local='en'
    (local.to_s == 'en' ? RESERVE_ADVANCE_NOTIFY_ENGLISH : RESERVE_ADVANCE_NOTIFY_CHINESE).each_with_index.map {|m,i| [m,i]}
  end

  def self.work_freq_notify_options local='en'
    (local.to_s == 'en' ? WORK_FREQ_NOTIFY_ENGLISH : WORK_FREQ_NOTIFY_CHINESE).each_with_index.map {|m,i| [m,i]}
  end

  def self.best_applying_at_options local='en'
    puts "en:::::::#{local}"
    (local.to_s == 'en' ? BEST_APPLYING_AT_ENGLISH : BEST_APPLYING_AT_CHINESE).each_with_index.map {|m,i| [m,i]}
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

  def universities_accepted local='en'
    unis = []
    self.uni_accepted.map {|uni| unis.push((local.to_s == 'en' ? UNIVERSITIES_ENGLISH : UNIVERSITIES_CHINESE)[uni.to_i])}
    unis
  end

  def university_name local='en'
    (local.to_s == 'en' ? UNIVERSITIES_ENGLISH : UNIVERSITIES_CHINESE)[self.university.to_i]
  end

  def specialization_name local='en'
    (local.to_s == 'en' ? SPECIALIZATIONS_ENGLISH : SPECIALIZATIONS_CHINESE)[self.specialization.to_i]
  end

  def degree_completed_name local='en'
    (local.to_s == 'en' ? DEGREE_COMPLETED_ENGLISH : DEGREE_COMPLETED_CHINESE)[self.degree_completed.to_i]
  end

  def privacy_terms
    terms = []
    terms.push "Allow to share edited files" if self.share_edited_files
    terms.push "Allow to share my information" if self.share_info
    terms.push "Allow to meet in person" if self.meet_in_person
    terms.push "Allow to answer questions for free" if self.answer_free
    terms.push "Allow to ask personal questions" if self.personal_questions
    terms
  end

  def things_to_know
    terms = []
    terms.push "For a sense of accomplishment" if self.accomplishment
    terms.push "I want to utilize my free time" if self.free_time
    terms.push "I don't know how to write actually" if self.how_to_write
    terms.push "I am more nervous than you when I help you apply" if self.nervous
    terms.push "I care about your cooperation very much" if self.care_cooperation
    terms
  end

  def things_can_share
    terms = []
    terms.push I18n.t("things_can_share.cv") if self.share_resume
    terms.push I18n.t("things_can_share.app_letter") if self.share_application_essay
    terms.push I18n.t("things_can_share.offer_letter") if self.share_offer_letter
    terms.push I18n.t("things_can_share.gpa") if self.share_gpa
    terms.push I18n.t("things_can_share.gre") if self.share_gre_score
    terms.push I18n.t("things_can_share.papper") if self.share_paper
    terms.push I18n.t("things_can_share.essay") if self.share_course_essay
    terms
  end

  def experience_as_totur local = 'en'
    (local.to_s == 'en' ? TUTOR_BEFORE_ENGLISH : TUTOR_BEFORE_CHINESE)[self.tutor_before.to_i]
  end

  def reserve_in_advance local = 'en'
    (local.to_s == 'en' ? RESERVE_ADVANCE_NOTIFY_ENGLISH : RESERVE_ADVANCE_NOTIFY_CHINESE)[self.reserve_advance.to_i]
  end

  def self.specialization_as_collection  local = 'en'
    (local.to_s == 'en' ? SPECIALIZATIONS_ENGLISH : SPECIALIZATIONS_CHINESE).each_with_index.map {|m,i| [m,i]}
  end

  def self.search params
    keys = []
    if params[:service].present?
      case params[:service]
      when "0"
        keys.push 'consulting_tutor = :service'
      when "1"
        keys.push 'brainstorming_tutor = :service'
      when "2"
        keys.push 'writing_tutor = :service'
      when "3"
        keys.push 'visa_consultant = :service'
      end
    end
    if params[:specialization].present?
      keys.push 'specialization = :specialization'
    end
    InstructorInfo.where(keys.join(" and "), service: 1, specialization: params[:specialization]).limit(20)
  end

  def self.is_graduate_options local='en'
    (local.to_s == 'en' ? IS_GRADUATE_OPTIONS_ENGLISH : IS_GRADUATE_OPTIONS_CHINES).reverse.each_with_index.map {|m,i| [m,i==0]}
  end

end
