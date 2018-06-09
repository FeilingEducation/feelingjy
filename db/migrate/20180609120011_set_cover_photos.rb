class SetCoverPhotos < ActiveRecord::Migration[5.1]

  def change
    University.find_each do |uni|
      uni.picture = uni.gallery_images.first
      uni.save
    end
  end
end
