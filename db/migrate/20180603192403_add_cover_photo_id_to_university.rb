class AddCoverPhotoIdToUniversity < ActiveRecord::Migration[5.1]
  def change
    add_reference :universities, :picture, foreign_key: true
  end
end
