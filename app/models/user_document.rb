class UserDocument < ApplicationRecord
  belongs_to :user_info
  mount_uploader :file, UserDocumentUploader

  before_validation :update_file_attributes

  private

  def update_file_attributes
    self.md5 = file.md5
  end
end
