class Payment < ApplicationRecord
  # TODO: barely implemented
  belongs_to :payable, polymorphic: true

  after_create :create_user_wallet_activity

  enum status: {
    initiated: 1,
    pending: 2,
    completed: 3
  }

  def create_user_wallet_activity
    
  end
end
