class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  force_ssl if: :ssl_configured?

  NotAuthorized = Class.new(StandardError)

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def restrict_to_development
    not_found unless Rails.env.development?
  end

  # use logged_out=1 query to distinguish unauthorized page access and log out
  # from privileged page: the first one goes to sign in page while the second
  # goes to home
  def after_sign_out_path_for(resource_or_scope)
    # path before sign out request
    "#{URI(request.referer).path}?logged_out=1"
  end

  def data
    seeds
    render json: {message: "data inserted successfully"}  and return
  end

  def seed_graduate_data
    graduate_data
    render json: {message: "data inserted successfully"}  and return
  end

  def after_sign_in_path_for(resource_or_scope)
    # TODO: better way to detect sign up request; override maybe?
    # if request.env['PATH_INFO'] == new_user_registration_path && request.method_symbol == :post
    #   # jump to account path when first registered
    #   user_info_path
    # else
      stored_location_for(resource_or_scope) || signed_in_root_path(resource_or_scope)
    # end
  end

  # no longer used as user_info will always created at registration.
  def check_user_info_initialized
    exists = UserInfo.exists?(current_user.id)
    create = controller_name == 'user_infos' && %w(new create).include?(action_name)
    if exists && create
      redirect_to(user_info_path)
    elsif !exists && !create
      flash[:notice] = "Page will be available after filling in your information."
      redirect_to(new_user_info_path)
    end
  end

  # if instructor_info not initialized and user tries to access instructor pages
  # other than create and new, go to new, vise versa.
  def check_instructor_info_initialized
    exists = InstructorInfo.exists?(current_user.id)
    create = controller_name == 'instructor_infos' && %w(new create).include?(action_name)
    if exists && create
      redirect_to(edit_instructor_info_path)
    elsif !exists && !create
      flash[:notice] = "Page will be available after filling in your information."
      redirect_to(new_instructor_info_path)
    end
  end

  def reset_database
    if params[:key] == Rails.application.secrets.db_key
      reset_db
      render json: {message: "DB reset successfully!"}  and return
    else
      render json: {message: "not a valid key!"}  and return
    end
  end

  private
    # Set Local for translation
    def set_locale
      puts "========#{Rails.env}"
      # puts '********'
      # puts "#{Rails.application.secrets}*********"
      I18n.locale = session[:locale] || I18n.default_locale
    end

    # rails-config given:
    # config.secure_envs = %w(production staging for_my_girl_omfg_she_will_be_like_u_such_nasty_nerd_wtf)
    def ssl_configured?
      Rails.env.production? && request.path != '/cable'
    end

    def graduate_data
      puts "\n\n\n\n\nInsert YALE data\n\n\n\n"
      files = ['Yale.xlsx', 'university_of_fl.xlsx']
      files.each do |file_name|
        workbook = RubyXL::Parser.parse(Rails.root.join('public', 'data', file_name))
        worksheet = workbook.worksheets[0]

        worksheet.each_with_index do |row, index|
          next if index == 0
          cells = row.cells
          uni_name = cells[0].try(:value)
          dept_name = cells[1].try(:value)
          prog_name = cells[2].try(:value)

          next unless uni_name.present?
          next unless dept_name.present?
          next unless prog_name.present?
          uni = University.where(name_en: uni_name).first_or_create
          puts "Found university: #{uni_name}. Looking for its department #{dept_name}"
          dept = uni.departments.where(name_en: dept_name).first_or_create
          cells[3].value.split(",").each do |degree|
            degree = "Master" if degree == 'M.A.'
            program = dept.programs.where(name_en: prog_name, degree: degree).first_or_create
            program.name_en = cells[2].try(:value)
            # program.degree = degree
            puts "cells[4]::#{cells[4]}"
            program.website = cells[4].try(:value)
            # program.adminssion = cells[5].try(:value)
            program.fall_deadline = cells[5].try(:value)
            program.fall_deadline_round1 = cells[6].try(:value)
            program.fall_deadline_round2 = cells[7].try(:value)
            program.spring_deadline = cells[8].try(:value)
            program.addmission_requirements = cells[9].try(:value)
            program.contact = cells[10].try(:value)
            program.tution = cells[11].try(:value)
            program.note_en = cells[13].try(:value) || ""
            program.save!
          end
        end
      end
    end

    # TODO Move it somewhere else.
    def seeds
      # Create Universities. !!!!
      puts "\n\n\n\n\nCreating Universities!!!\n\n\n\n"
      workbook = RubyXL::Parser.parse(Rails.root.join('public', 'data', 'Universities.xlsx'))
      worksheet = workbook[1]
      worksheet.each_with_index do |row, index|
        next if index == 0
        cells = row.cells
        uni_name = cells[0].value
        next unless uni_name.present?
        uni = University.where(name_en: uni_name).first_or_create
        uni.name_en = cells[0].value
        uni.web_link = cells[1].value
        uni.contact = cells[2].value
        uni.address = cells[3].value
        uni.grad_website = cells[4].value
        uni.grad_contact = cells[5].value
        uni.grad_address = cells[6].value
        uni.program_list = cells[7].value
        uni.overview = cells[10].value
        uni.news_18 = cells[11].value
        uni.news_17 = cells[12].value
        uni.description_en = cells[13].value
        uni.save
      end

      # Create Departments. !!!!
      puts "\n\n\n\n\nCreating departments!!!\n\n\n\n"
      workbook = RubyXL::Parser.parse(Rails.root.join('public', 'data', 'Departments.xlsx'))
      worksheet = workbook[1]
      worksheet.each_with_index do |row, index|
        next if index == 0
        cells = row.cells
        uni_name = cells[1].value
        dept_name = cells[2].value
        next unless uni_name.present?
        next unless dept_name.present?
        uni = University.where(name_en: uni_name).first_or_create
        puts "Found university: #{uni_name}. Looking for its department #{dept_name}"
        dept = uni.departments.where(name_en: dept_name).first_or_create
        dept.website = cells[3].value
        dept.address = cells[4].value
        dept.contact = cells[5].value
        dept.program_list = cells[6].value
        dept.tofel_code = cells[7].value
        dept.gre_code = cells[8].value
        dept.gmat_code = cells[9].value
        dept.save!
      end

      # Create Programs. !!!!
      puts "\n\n\n\n\nCreating Programsssss!!!\n\n\n\n"
      workbook = RubyXL::Parser.parse(Rails.root.join('public', 'data', 'Programs.xlsx'))
      worksheet = workbook[1]
      worksheet.each_with_index do |row, index|
        next if index == 0
        cells = row.cells
        uni_name = cells[0].value
        dept_name = cells[1].value
        prog_name = cells[2].value
        next unless uni_name.present?
        next unless dept_name.present?
        next unless prog_name.present?
        uni = University.where(name_en: uni_name).first_or_create
        puts "Found university: #{uni_name}. Looking for its department #{dept_name}"
        dept = uni.departments.where(name_en: dept_name).first_or_create
        program = dept.programs.where(name_en: prog_name).first_or_create
        program.name_en = cells[2].value
        program.degree = cells[3].value
        program.website = cells[4].value
        program.adminssion = cells[5].value
        program.fall_deadline = cells[6].value
        program.fall_deadline_round1 = cells[7].value
        program.fall_deadline_round2 = cells[8].value
        program.spring_deadline = cells[9].value
        program.addmission_requirements = cells[10].value
        program.contact = cells[11].value
        program.tution = cells[12].value
        program.note_en = cells[13].value
        program.save!
      end

    end

    def reset_db
      Attachment.destroy_all
      ChatLine.destroy_all
      Chat.destroy_all
      ConsultTransaction.destroy_all
      Program.destroy_all
      Department.destroy_all
      InstructorInfo.destroy_all
      Message.destroy_all
      Payment.destroy_all
      Picture.destroy_all
      PrivatePolicy.destroy_all
      Review.destroy_all
      UserInfo.destroy_all
      UserWalletActivity.destroy_all
      UserWallet.destroy_all
      User.destroy_all
    end

end
