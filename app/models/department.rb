class Department < ApplicationRecord

  belongs_to :university

  has_many :gallery_images, class_name: 'Picture', foreign_key: 'pictureable_id'
  accepts_nested_attributes_for :gallery_images

  after_create :set_pictureable
  after_save :set_pictureable

  def name local='en'
    local == 'en' ? name_en : name_cn
  end

  def details local='en'
    local == 'en' ? details_en : details_cn
  end

  def set_pictureable
    Picture.where(uuid: self.uuid).find_each do |picture|
      picture.pictureable = self
      picture.save
    end
  end
end
