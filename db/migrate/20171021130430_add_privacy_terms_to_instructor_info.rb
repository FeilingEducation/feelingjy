class AddPrivacyTermsToInstructorInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :instructor_infos, :share_edited_files, :boolean
    add_column :instructor_infos, :share_info, :boolean
    add_column :instructor_infos, :meet_in_person, :boolean
    add_column :instructor_infos, :answer_free, :boolean
    add_column :instructor_infos, :personal_questions, :boolean
    add_column :instructor_infos, :accomplishment, :boolean
    add_column :instructor_infos, :free_time, :boolean
    add_column :instructor_infos, :how_to_write, :boolean
    add_column :instructor_infos, :nervous, :boolean
    add_column :instructor_infos, :care_cooperation, :boolean
  end
end
