class ChangeColumnTypeOfSpecialization < ActiveRecord::Migration[5.1]
  def change
    change_column :instructor_infos, :specialization, "varchar[] USING (string_to_array(specialization, ','))"
  end
end
