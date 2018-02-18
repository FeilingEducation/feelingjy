module InstructorInfosHelper

  def services_of instructor
    services = []
    # if instructor.is_early_consult
      services << '前期咨询'
    # end
    # if instructor.is_brainstorm_consult
      services << '头脑风暴'
    # end
    # if instructor.is_essay_consult
      services << '文书改写'
    # end
    # if instructor.is_visa_consult
      services << '签证咨询'
    # end
    # if services.empty?
    #   services << '暂无服务'
    # end
    services
  end

  def services_as_collection
    ["Early Consultant","Brainstroming Consultant", "Essay Consultant", "Visa Consultant"].each_with_index.map {|m,i| [m,i]}
  end


  def uni_logo uni, local='en'
    uni_english = ["Brown University","California Institute of Technology (Caltech)","Columbia University","Cornell University","Dartmouth College","Duke University","Emory University","Georgetown University","Harvard University","Johns Hopkins University","Massachusetts Institute of Technology (MIT)","Northwestern University","Princeton University","Rice University","Stanford University","UC Berkeley","UCLA","University of Chicago","University of Notre Dame", "University of Pennsylvania", "University of Southern California", "University of Virginia", "University of Wisconsin-Madison","Vanderbilt University","Washington University in St. Louis","Yale University"]
    uni_chinese = ['布朗大学','加州理工学院','哥伦比亚大学','康奈尔大学','达特茅斯学院','杜克大学','埃默里大学','乔治城大学','哈佛大学','约翰霍普金斯大学','麻省理工学院','西北大学','普林斯顿大学','莱斯大学','斯坦福大学','加州大学伯克利分校','加州大学洛杉矶分校','芝加哥大学','圣母大学','宾夕法尼亚大学','南加州大学','弗吉尼亚大学','威斯康辛大学麦迪逊分校','范德堡大学','圣路易斯华盛顿大学','耶鲁大学']
    local.to_s == 'en' ? uni : uni_english[uni_chinese.index(uni)]
  end
end
