class InstructorInfo < ApplicationRecord

  belongs_to :user_info, :foreign_key => :id
  # delegate some fields to the UserInfo, which might incurr extra BD lookup
  delegate :first_name, :last_name, :full_name, :gender, :avatar, :phone_number, :attachments, :email, :user_id, to: 'user_info'

  has_many :consult_transactions, foreign_key: 'instructor_id', dependent: :destroy
  has_many :students, through: 'consult_transactions', dependent: :destroy
  has_many :private_policies, foreign_key: 'instructor_id', dependent: :destroy

  attr_accessor :avatar_cache

  # TODO: maybe unify it with a more general uploader
  mount_uploader :page_background, PageBackgroundUploader

  validates_presence_of :id, on: [:create]

  UNIVERSITIES_ENGLISH = [
                          #A
                          #B
                          "Boston College",
                          "Boston University",
                          "Brandeis University",
                          "Brown University",
                          #C
                          "Case Western Reserve University",
                          "California Institute of Technology (Caltech)",
                          "Carnegie Mellon University",
                          "College of William and Mary",
                          "Columbia University",
                          "Cornell University",
                          #D
                          "Dartmouth College",
                          "Duke University",
                          #E
                          "Emory University",
                          #F
                          #G
                          "Georgetown University",
                          "Georgia Institute of Technology",
                          #H
                          "Harvard University",
                          #I
                          #J
                          "Johns Hopkins University",
                          #K
                          #L
                          "Lehigh University",
                          #M
                          "Massachusetts Institute of Technology (MIT)",
                          #N
                          "New York University",
                          "Northeastern University",
                          "Northwestern University",
                          #O
                          #P
                          "Princeton University",
                          #Q
                          #R
                          "Rice University",
                          #S
                          "Stanford University",
                          #T
                          "Tufts University",
                          "Tulane University",
                          #U
                          "UC Berkeley",
                          "University of California-Davis",
                          "UCLA",
                          "University of California-Irvine",
                          "University of California-Santa Barbara",
                          "University of California-San Diego",
                          "University of Chicago",
                          "University of Florida",
                          "University of Maryland-College Park",
                          "University of Miami",
                          "University of North Carolina-Chapel Hill",
                          "University of Notre Dame",
                          "University of Pennsylvania",
                          "University of Pittsburgh",
                          "University of Rochester",
                          "University of Southern California",
                          "University of Texas-Austin",
                          "University of Virginia",
                          "University of Washington at Seattle",
                          "University of Wisconsin-Madison",

                          #V
                          "Vanderbilt University",
                          #W
                          "Wake Forest University",
                          "Washington University in St. Louis",
                          #X
                          #Y
                          "Yale University"
                          #Z
                         ]

  UNIVERSITIES_CHINESE = [
                          #A
                          #B
                          '波士顿学院(Boston College)',
                          '波士顿大学(Boston University)',
                          '布兰迪斯大学(Brandeis University)',
                          '布朗大学(Brown University)',
                          #C
                          '凯斯西储大学(Case Western Reserve University)',
                          '加州理工学院(California Institute of Technology (Caltech))',
                          '卡耐基梅隆大学 (Carnegie Mellon University)',
                          '威廉玛丽学院(College of William and Mary)',
                          '哥伦比亚大学(Columbia University)',
                          '康奈尔大学(Cornell University)',
                          #D
                          '达特茅斯学院(Dartmouth College)',
                          '杜克大学(Duke University)',
                          #E
                          '埃默里大学(Emory University)',
                          #F
                          #G
                          '乔治城大学(Georgetown University)',
                          '佐治亚理工学院(Georgia Institute of Technology)',
                          #H
                          '哈佛大学(Harvard University)',
                          #I
                          #J
                          '约翰霍普金斯大学(Johns Hopkins University)',
                          #K
                          #L
                          '理海大学(Lehigh University)',
                          #M
                          '麻省理工学院(Massachusetts Institute of Technology (MIT))',
                          #N
                          '纽约大学(New York University)',
                          '东北大学(Northeastern University)',
                          '西北大学(Northwestern University)',
                          #O
                          #P
                          '普林斯顿大学(Princeton University)',
                          #Q
                          #R
                          '莱斯大学(Rice University)',
                          #S
                          '斯坦福大学(Stanford University)',
                          #T
                          '塔夫斯大学(Tufts University)',
                          '杜兰大学(Tulane University)',
                          #U
                          '加州大学伯克利分校(University of California-Berkeley)',
                          '加州大学戴维斯分校(University of California-Davis)',
                          '加州大学欧文分校(University of California-Irvine)',
                          '加州大学洛杉矶分校(UCLA)',
                          '加州大学圣巴巴拉分校(University of California-Santa Barbara)',
                          '加州大学圣地亚哥分校(University of California-San Diego)',
                          '芝加哥大学(University of Chicago)',
                          '马里兰大学帕克分校(University of Maryland-College Park)',
                          '迈阿密大学(University of Miami)',
                          '佛罗里达大学(University of Florida)',
                          '北卡罗来纳大学(University of North Carolina-Chapel Hill)',
                          '圣母大学(University of Notre Dame)',
                          '宾夕法尼亚大学(University of Pennsylvania)',
                          '匹兹堡大学(University of Pittsburgh)',
                          '罗切斯特大学(University of Rochester)',
                          '南加州大学(University of Southern California)',
                          '德克萨斯大学奥斯汀分校(University of Texas-Austin)',
                          '弗吉尼亚大学(University of Virginia)',
                          '华盛顿大学西雅图分校(University of Washington at Seattle)',
                          '威斯康辛大学麦迪逊分校(University of Wisconsin-Madison)',
                          #V
                          '范德堡大学(Vanderbilt University)',
                          #W
                          '圣路易斯华盛顿大学(Washington University in St. Louis)',
                          '维克森林大学(Wake Forest University)',
                          #X
                          #Y
                          '耶鲁大学(Yale University)'
                          #Z
                         ]


  SPECIALIZATIONS_ENGLISH = ["Arts & Humanities",
                             "Biological Sciences",
                             "Business",
                             "Chemistry",
                             "Civil Engineering",
                             "Computer Science",
                             "Electrical Engineering",
                             "Engineering",
                             "Literature",
                             "Language",
                             "Law",
                             "Neurobiology",
                             "Mechanical Engineering",
                             "Management",
                             "Mathematics",
                             "Physics"]

  SPECIALIZATIONS_CHINESE = ["艺术与人文领域",
                             "生命科学",
                             "商科",
                             "化学",
                             "土木工程",
                             "计算机科学",
                             "电气工程",
                             "工程",
                             "文学",
                             "语言",
                             "法律",
                             "神经学",
                             "机械工程",
                             "管理",
                             "数学",
                             "物理"]

  DEGREE_COMPLETED_ENGLISH = ["Bachelor (junior)", "Bachelor (senior)", "First year graduate student", "Second year graduate student", "PhD","Bachelor (graduated)","Master (graduated)", "PhD (graduated)"]
  DEGREE_COMPLETED_CHINESE = ['在读本科第三年','在读本科第四年', '在读研究生第一年', '在读研究生第二年', '在读博士','本科（已毕业）','研究生（已毕业）','博士（已毕业）']

  TUTOR_OPTIONS_ENGLISH = ['Yes, I can do this', 'No, I can\'t do this']
  TUTOR_OPTIONS_CHINESE = ['是的, 我能做这些', '抱歉, 我做不了这些']

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



# lei added
def self.find_degree(degree_name)
   I18n.t("activerecord.attributes.instructor_info.degree.#{degree_name.to_s}")
end

def self.find_university(university_name)
   I18n.t("activerecord.attributes.instructor_info.university.#{university_name.to_s}")
end

# def self.find_specialization(specialization_name)
#    I18n.t("activerecord.attributes.instructor_info.specialization.#{specialization_name.to_s}")
# end
#


  def resumes
    self.attachments.where(file_type: 'resume')
  end

  def self.universities_as_optons local='en'
    puts "local::::::#{local}"
    puts "local.to_s == 'en':::::: #{local.to_s == 'en'}"
    puts "local.to_s == 'en':::: #{local.to_s == "en"}"
    (local.to_s == "en" ? University.all : University.all).map {|u| [u.name_en,u.id]}
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
    spceializations = []
    self.specialization.map {|s| spceializations.push((local.to_s == 'en' ? SPECIALIZATIONS_ENGLISH : SPECIALIZATIONS_CHINESE)[s.to_i])}
    spceializations
  end

  def degree_completed_name local='en'
    (local.to_s == 'en' ? DEGREE_COMPLETED_ENGLISH : DEGREE_COMPLETED_CHINESE)[self.degree_completed.to_i]
  end

  def privacy_terms local='en'
    terms = []
    if local.to_s == 'en'
      terms.push "Allow to share edited files" if self.share_edited_files
      terms.push "Allow to share my information" if self.share_info
      terms.push "Allow to meet in person" if self.meet_in_person
      terms.push "Allow to answer questions for free" if self.answer_free
      terms.push "Allow to ask personal questions" if self.personal_questions
    else
      terms.push "允许分享改好的文书" if self.share_edited_files
      terms.push "允许分享个人信息" if self.share_info
      terms.push "允许面对面见面" if self.meet_in_person
      terms.push "允许为学生免费答疑问题" if self.answer_free
      terms.push "允许问私人问题" if self.personal_questions
    end
    terms
  end

  def things_to_know local='en'
    terms = []
    if local.to_s == 'en'
      terms.push "For a sense of accomplishment" if self.accomplishment
      terms.push "I want to utilize my free time" if self.free_time
      terms.push "I don't know how to write actually" if self.how_to_write
      terms.push "I am more nervous than you when I help you apply" if self.nervous
      terms.push "I care about your cooperation very much" if self.care_cooperation
    else
      terms.push "我做导师是为了实现价值" if self.accomplishment
      terms.push "我做导师是为了把零散时间利用起来" if self.free_time
      terms.push "我根本不会写作" if self.how_to_write
      terms.push "我其实比您还要紧张" if self.nervous
      terms.push "我特别在意我们之间合作的体验" if self.care_cooperation
    end
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

  # def self.specialization_as_collection  local = 'en'
  #   (local.to_s == 'en' ? SPECIALIZATIONS_ENGLISH : SPECIALIZATIONS_CHINESE).each_with_index.map {|m,i| [m,i]}
  # end

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
      keys.push ":specialization =ANY(specialization)"
      # keys.push 'specialization = :specialization'
    end

    InstructorInfo.where(keys.join(" and "), service: 1, specialization: params[:specialization]).limit(20)
  end

  def self.is_graduate_options local='en'
    (local.to_s == 'en' ? IS_GRADUATE_OPTIONS_ENGLISH : IS_GRADUATE_OPTIONS_CHINES).reverse.each_with_index.map {|m,i| [m,i==0]}
  end

  def notify_advance local='en'
    (local.to_s == 'en' ? ADVANCE_NOTIFY_ENGLISH : ADVANCE_NOTIFY_CHINESE)[self.advance_notify.to_i]
  end

  def advance_work local='en'
    (local.to_s == 'en' ? RESERVE_ADVANCE_NOTIFY_ENGLISH : RESERVE_ADVANCE_NOTIFY_CHINESE)[self.reserve_in_advance.to_i]
  end

end
