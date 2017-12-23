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
end
