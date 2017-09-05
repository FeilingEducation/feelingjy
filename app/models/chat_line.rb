class ChatLine < ApplicationRecord
  belongs_to :chat
  belongs_to :user_info
end
