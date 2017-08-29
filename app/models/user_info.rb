class UserInfo < ApplicationRecord

  mount_uploader :avatar, AvatarUploader

  belongs_to :user, foreign_key: 'id'

  validates_presence_of :id

  validates :first_name, :presence => true,
                         :length => { :maximum => 20 }
  validates :last_name, :presence => true,
                        :length => { :maximum => 20 }
  validates :gender, :presence => true,
                     :inclusion => { in: (0..2) }

end
