class AddInsituteAppliedToInstructorInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :instructor_infos, :number_institutes_applied, :integer
    add_column :instructor_infos, :number_institutes_admitted, :integer
    add_column :instructor_infos, :share_resume, :boolean, default: false
    add_column :instructor_infos, :share_application_essay, :boolean, default: false
    add_column :instructor_infos, :share_offer_letter, :boolean, default: false
    add_column :instructor_infos, :share_gpa, :boolean, default: false
    add_column :instructor_infos, :share_gre_score, :boolean, default: false
    add_column :instructor_infos, :share_paper, :boolean, default: false
    add_column :instructor_infos, :share_course_essay, :boolean, default: false
    add_column :instructor_infos, :page_name, :string
  end
end
