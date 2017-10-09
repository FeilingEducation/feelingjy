class Message < ApplicationRecord

  has_many :attachments, as: 'attachable'
  belongs_to :sender, class_name: :UserInfo
  belongs_to :receiver, class_name: :UserInfo

  # implemented for "attachable" object so that we can check if a user is authorized
  # to modify an attachment, which contains no user information (attachable is the owner)
  def authorized_by(user)
    user.id == self.sender_id
  end
end
