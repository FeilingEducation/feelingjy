class AddTimestampToInstructorInfos < ActiveRecord::Migration[5.1]
  def change
    change_table :instructor_infos do |t|
      t.timestamps
    end
  end
end
