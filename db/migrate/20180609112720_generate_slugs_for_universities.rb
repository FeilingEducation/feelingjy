class GenerateSlugsForUniversities < ActiveRecord::Migration[5.1]
  def change
    University.find_each.collect(&:save)
  end
end
