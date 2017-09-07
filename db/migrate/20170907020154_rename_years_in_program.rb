class RenameYearsInProgram < ActiveRecord::Migration[5.1]
  def change
    rename_column :user_infos, :years_in_program, :program_year
  end
end
