class CreateInstructorInfos < ActiveRecord::Migration[5.1]
  def change
    # should share the same id as user nad user_info
    create_table :instructor_infos do |t|
      # personal info
      t.text :consult_experience
      t.text :previous_applications
      t.text :previous_offers
      t.string :gpa
      t.string :gre_score
      t.text :suggestions_to_students
      t.string :specialties
      t.string :page_title
      # calendar related  (TODO: maybe use another databsae?)
      t.text :available_time_slots
      t.text :busy_events
      # preferred consult types
      t.boolean :is_early_consult
      t.boolean :is_brainstorm_consult
      t.boolean :is_essay_consult
      t.boolean :is_visa_consult
      # consult preference
      t.integer :consult_capacity_min
      t.integer :consult_capacity_max
      t.integer :consult_term_min
      t.integer :consult_term_max
      t.integer :consult_duration_min
      t.integer :consult_duration_max
      t.integer :consult_reserve_earliest
      t.integer :consult_reserve_latest
      t.string :consult_frequency
      t.text :privacy_policy_template
      t.string :pricing_strategy
      t.integer :price_min
      t.integer :price_max
      t.integer :price_base
    end
  end
end
