class Picture < ApplicationRecord
  before_validation :assign_picturable

  belongs_to :pictureable, class_name: "University" #, polymorphic: true

  has_attached_file :image,
      :storage => :s3,
      s3_region: 'us-west-1',
      s3_host_name: 's3-us-west-1.amazonaws.com',
      styles: { medium: "300x300>", thumb: "100x100>" },
      :s3_credentials => Proc.new{|a| a.instance.s3_credentials }

  validates_with AttachmentSizeValidator, attributes: :image, less_than: 1.megabytes

  # validates_attachment_file_name :logo, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/]

  do_not_validate_attachment_file_type :image

  def s3_credentials
    {:bucket => Rails.application.secrets.s3_bucket_name,
    :access_key_id => Rails.application.secrets.aws_access_key_id ,
    :secret_access_key => Rails.application.secrets.aws_secret_access_key}
  end

  def assign_picturable

  end

  # def name local='en'
  #   local == 'en' ? name_en : name_cn
  # end

end
