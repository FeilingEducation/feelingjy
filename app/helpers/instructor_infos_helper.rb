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
      ["Arts & Humanities", "Biological Sciences", "Business", "Computer Science", "Engineering", "Literature", "Law", "Management", "Mathematics", "Physics"].each_with_index.map {|m,i| [m,i]}
    else
      ["艺术与人文领域", "生命科学", "商科", "计算机科学", "工程", "文学", "法律", "管理", "数学", "物理"].each_with_index.map {|m,i| [m,i]}
    end
  end

  def uni_logo uni, local='en'
    uni_english = ["Brown University","California Institute of Technology (Caltech)","Columbia University","Cornell University","Dartmouth College","Duke University","Emory University","Georgetown University","Harvard University","Johns Hopkins University","Massachusetts Institute of Technology (MIT)","Northwestern University","Princeton University","Rice University","Stanford University","UC Berkeley","UCLA","University of Chicago","University of Notre Dame", "University of Pennsylvania", "University of Southern California", "University of Virginia", "University of Wisconsin-Madison","Vanderbilt University","Washington University in St. Louis","Yale University"]
    uni_chinese = ['布朗大学','加州理工学院','哥伦比亚大学','康奈尔大学','达特茅斯学院','杜克大学','埃默里大学','乔治城大学','哈佛大学','约翰霍普金斯大学','麻省理工学院','西北大学','普林斯顿大学','莱斯大学','斯坦福大学','加州大学伯克利分校','加州大学洛杉矶分校','芝加哥大学','圣母大学','宾夕法尼亚大学','南加州大学','弗吉尼亚大学','威斯康辛大学麦迪逊分校','范德堡大学','圣路易斯华盛顿大学','耶鲁大学']
    local.to_s == 'en' ? uni : uni_english[uni_chinese.index(uni)]
  end
end
