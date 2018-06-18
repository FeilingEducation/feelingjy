# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

# University.where(name_en: "Uni name in engilis", name_cn: "Uni name in chinese", description: "Some text description regarding University.").first_or_create

# require 'spreadsheet'
# Spreadsheet.client_encoding = 'UTF-8'
#
# book = Spreadsheet.open Rails.root.join('public', 'data', 'Departments.xlsx')
#
# sheet1 = book.worksheet 0
#
# sheet1.each do |row|
#   puts row.insepect
#   puts "*8******8"
#   # do something interesting with a row
# end
#
# require 'roo'
#
# # xlsx = Roo::Spreadsheet.open('./new_prices.xlsx')
# # xlsx = Roo::Excelx.new("./new_prices.xlsx")
#
# # Use the extension option if the extension is ambiguous.
# puts "Rails.root.join('public', 'data', 'departments.numbers')::: #{Rails.root.join('public', 'data', 'departments.xlsx')}"
# xlsx = Roo::Spreadsheet.open(Rails.root.join('public', 'data', 'departments.xlsx'), extension: :xlsx)
#
# # puts "=----"
# # puts xlsx.sheets
#
# xlsx.each_with_pagename do |name, sheet|
#   p sheet.row(1)
# end



require 'rubyXL'


# Create Universities. !!!!
puts "\n\n\n\n\nCreating Universities!!!\n\n\n\n"

workbook = RubyXL::Parser.parse(Rails.root.join('public', 'data', 'Universities.xlsx'))
worksheet = workbook[1]

# puts "worksheet:::#{worksheet.inspect}"
worksheet.each_with_index do |row, index|

  next if index == 0

  cells = row.cells
  uni_name = cells[0].value
  uni = University.where(name_en: uni_name).first_or_create

  uni.name_en = cells[0]
  uni.web_link = cells[1]
  uni.contact = cells[2]
  uni.address = cells[3]
  uni.grad_website = cells[4]
  uni.grad_contact = cells[5]
  uni.grad_address = cells[6]
  uni.program_list = cells[7]

  uni.overview = cells[10]
  uni.news_18 = cells[11]
  uni.news_17 = cells[12]
  uni.description_en = cells[13]

  uni.save

end



# Create Departments. !!!!
puts "\n\n\n\n\nCreating departments!!!\n\n\n\n"

workbook = RubyXL::Parser.parse(Rails.root.join('public', 'data', 'Departments.xlsx'))
worksheet = workbook[1]
# puts "worksheet:::#{worksheet.inspect}"
worksheet.each_with_index do |row, index|
  next if index == 0
  cells = row.cells

  uni_name = cells[1].value
  dept_name = cells[2].value

  uni = University.where(name_en: uni_name).first_or_create

  if uni.nil?
    puts "Could't find university!! **************** #{uni_name} ******************"
  else
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
end


# Create Programs. !!!!
puts "\n\n\n\n\nCreating Programsssss!!!\n\n\n\n"

workbook = RubyXL::Parser.parse(Rails.root.join('public', 'data', 'Programs.xlsx'))
worksheet = workbook[1]
# puts "worksheet:::#{worksheet.inspect}"
worksheet.each_with_index do |row, index|
  next if index == 0
  cells = row.cells

  uni_name = cells[0].value
  dept_name = cells[1].value
  prog_name = cells[2].value

  uni = University.where(name_en: uni_name).first_or_create

  if uni.nil?
    puts "Could't find university!! **************** #{uni_name} ******************"
  else
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
