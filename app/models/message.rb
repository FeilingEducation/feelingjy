class Message < ApplicationRecord

  has_many :attachments, as: 'attachable'
  belongs_to :sender, class_name: :UserInfo
  belongs_to :receiver, class_name: :UserInfo

  def authorized_by(user)
    user.id == self.sender_id
  end
end
