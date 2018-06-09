class GenerateSlugsForDepartments < ActiveRecord::Migration[5.1]
  def change
    Department.find_each.collect(&:save)
  end
end
