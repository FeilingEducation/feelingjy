class SetUniversityData < ActiveRecord::Migration[5.1]
  def change
    University.find_each do |uni|
      uni.uuid = SecureRandom.uuid
      uni.save

      uni.gallery_images.each do |picture|
        picture.uuid = uni.uuid
        picture.save
      end
    end
  end
end
