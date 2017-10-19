class AddConsultingTutorToInstructorInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :instructor_infos, :consulting_tutor, :integer
    add_column :instructor_infos, :brainstorming_tutor, :integer
    add_column :instructor_infos, :writing_tutor, :integer
    add_column :instructor_infos, :visa_consultant, :integer
  end
end
