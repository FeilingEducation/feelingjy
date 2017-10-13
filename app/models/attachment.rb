class Attachment < ApplicationRecord
  # Currently UserInfo and Message are the two possible attachables for Attachment
  belongs_to :attachable, polymorphic: true
  mount_uploader :file, AttachmentUploader

  before_validation :update_file_attributes

  private

  def update_file_attributes
    self.md5 = file.md5
  end
end
