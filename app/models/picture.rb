class Picture < ApplicationRecord

  belongs_to :pictureable, polymorphic: true

  has_attached_file :image,
      :storage => :s3,
      :s3_credentials => Proc.new{|a| a.instance.s3_credentials }

  def s3_credentials
    {:bucket => Rails.application.secrets.s3_bucket_name,
    :access_key_id => Rails.application.secrets.aws_access_key_id ,
    :secret_access_key => Rails.application.secrets.aws_secret_access_key}
  end
  
end
