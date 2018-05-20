class UserWallet < ApplicationRecord
  belongs_to :user
  belongs_to :consult_transaction
  belongs_to :payment
end
