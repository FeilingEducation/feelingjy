class MakeGenderNullable < ActiveRecord::Migration[5.1]
  def change
    change_column_null :user_infos, :gender, true, 0
  end
end
