module InstructorInfosHelper

  def services_of instructor
    services = []
    if instructor.consulting_tutor
      services << [I18n.t("services.early_consultant"), 'early_consult']
    end
    if instructor.brainstorming_tutor
      services << [I18n.t("services.brainstorm_consultant"), 'brainstorm_consultant']
    end
    if instructor.writing_tutor
      services << [I18n.t("services.essay_consultant"), 'essay_consultant']
    end
    if instructor.visa_consultant
      services << [I18n.t("services.visa_consultant"), 'visa_consultant']
    end
    if services.empty?
      services << [I18n.t("services.all"), 'all']
    end
    services
  end

  def service service_name
    case service_name
    when "early_consult"
      I18n.t("services.early_consultant")
    when "brainstorm_consultant"
      I18n.t("services.brainstorm_consultant")
    when "essay_consultant"
      I18n.t("services.essay_consultant")
    when "visa_consultant"
      I18n.t("services.visa_consultant")
    when "all"
      I18n.t("services.all")
    end
  end

  #
  # def services_as_collection
  #   ["Early Consultant","Brainstroming Consultant", "Essay Consultant", "Visa Consultant"].each_with_index.map {|m,i| [m,i]}
  # end

  def services_as_collection
    # the dropdown items are chinese when cn is selected
    if(session[:locale]=='en' || session[:locale]==nil)
      ["Early Consultant","Brainstroming Consultant", "Essay Consultant", "Visa Consultant"].each_with_index.map {|m,i| [m,i]}
    else
      ["前期咨询","文书构思", "文书改写", "签证咨询"].each_with_index.map {|m,i| [m,i]}
    end
  end

  def specialization_as_collection
    # the dropdown items are chinese when cn is selected
    if(session[:locale]=='en' || session[:locale]==nil)
      ["Arts & Humanities",
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
       "Physics"].each_with_index.map {|m,i| [m,i]}
    else
      ["艺术与人文领域",
       "生命科学",
       "商科",
       "化学",
       "土木工程",
       "计算机科学",
       "电气工程",
       "工程",
       "文学",
       "语言",
       "神经学",
       "机械工程",
       "法律",
       "管理",
       "数学",
       "物理"].each_with_index.map {|m,i| [m,i]}
    end
  end

  def uni_logo uni, local='en'
    return "" if uni.nil?
    uni_english = ["Brown University","California Institute of Technology (Caltech)","Columbia University",
                   "Cornell University","Dartmouth College","Duke University","Emory University",
                   "Georgetown University","Harvard University","Johns Hopkins University",
                   "Massachusetts Institute of Technology (MIT)","Northwestern University","Princeton University",
                   "Rice University","Stanford University","UC Berkeley","UCLA","University of Chicago",
                   "University of Notre Dame", "University of Pennsylvania", "University of Southern California",
                   "University of Virginia", "University of Wisconsin-Madison","Vanderbilt University",
                   "Washington University in St. Louis","Yale University", "Carnegie Mellon University",
                   "Wake Forest University", "Tufts University", "New York University",
                   "University of North Carolina-Chapel Hill", "Boston College", "College of William and Mary",
                   "Brandeis University", "Georgia Institute of Technology", "University of Rochester",
                   "Boston University", "Case Western Reserve University", "University of California-Santa Barbara",
                   "Northeastern University", "Tulane University", "University of California-Irvine",
                   "University of California-San Diego", "University of Florida", "Lehigh University",
                   "University of California-Davis", "University of Miami", "University of Texas-Austin",
                   "University of Washington at Seattle", "University of Maryland-College Park", "University of Pittsburgh"
                  ]

    uni_chinese = [
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
                  ]


    # local.to_s == 'en'? uni : uni_english[uni_chinese.index(uni)]
    uni
  end
end
