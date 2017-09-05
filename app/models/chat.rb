class Chat < ApplicationRecord
  belongs_to :consult_transaction
  has_many :chat_lines
end
