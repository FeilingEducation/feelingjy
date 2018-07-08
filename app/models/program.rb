class Program < ApplicationRecord
  belongs_to :department, dependent: :destroy
end
