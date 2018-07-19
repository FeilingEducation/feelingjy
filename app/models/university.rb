class University < ApplicationRecord

  # has_one :cover_photo, class_name: 'Picture', foreign_key: 'pictureable_id'
  belongs_to :picture, class_name: 'Picture', optional: true #, foreign_key: "pictureable_id"
  has_many :gallery_images, class_name: 'Picture', foreign_key: 'pictureable_id',dependent: :destroy

  has_many :departments, dependent: :destroy
  has_many :programs, through: :departments, dependent: :destroy

  # accepts_nested_attributes_for :cover_photo
  accepts_nested_attributes_for :gallery_images

  extend FriendlyId
  friendly_id :name_en, use: :slugged

  has_attached_file :logo,
      :storage => :s3,
      s3_region: 'us-west-1',
      s3_host_name: 's3-us-west-1.amazonaws.com',
      styles: { medium: "300x300>", thumb: "100x100>" },
      :s3_credentials => Proc.new{|a| a.instance.s3_credentials }

  validates_with AttachmentSizeValidator, attributes: :logo, less_than: 1.megabytes

  # validates_attachment_file_name :logo, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/]

  do_not_validate_attachment_file_type :logo

  after_create :set_pictureable
  after_save :set_pictureable

  def s3_credentials
    {:bucket => Rails.application.secrets.s3_bucket_name,
    :access_key_id => Rails.application.secrets.aws_access_key_id ,
    :secret_access_key => Rails.application.secrets.aws_secret_access_key}
  end

  def name local='en'
    local == 'en' ? name_en : name_cn
  end

  def description local='en'
    local == 'en' ? description_en : description_cn
  end

  def cover_photo
    picture
  end

  def set_pictureable
    Picture.where(uuid: self.uuid).find_each do |picture|
      picture.pictureable = self
      picture.save
    end
  end

  def should_generate_new_friendly_id?
    new_record? || slug.blank?
  end
end
