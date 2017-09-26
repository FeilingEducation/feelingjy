class AddInstructorRating < ActiveRecord::Migration[5.1]
  def change
    add_column :instructor_infos, :avg_rating, :float
  end
end
