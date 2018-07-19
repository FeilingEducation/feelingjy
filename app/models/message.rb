class Message < ApplicationRecord

  has_many :attachments, as: 'attachable', dependent: :destroy
  belongs_to :sender, class_name: :UserInfo
  belongs_to :receiver, class_name: :UserInfo

  after_commit :broadcast_message

  # implemented for "attachable" object so that we can check if a user is authorized
  # to modify an attachment, which contains no user information (attachable is the owner)
  def authorized_by(user)
    user.id == self.sender_id
  end

  def broadcast_message
    puts "broadcasting... #{self.inspect}"
    MessageJob.perform_later(self)
  end
end
