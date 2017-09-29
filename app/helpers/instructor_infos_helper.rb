module InstructorInfosHelper

  def service_options_for(instructor)
    options = []
    if instructor.is_early_consult
      options << "前期咨询"
    end
    if instructor.is_brainstorm_consult
      options << "头脑风暴"
    end
    if instructor.is_essay_consult
      options << "文书改写"
    end
    if instructor.is_visa_consult
      options << "签证咨询"
    end
    return options_for_select(options, nil)
  end
end
