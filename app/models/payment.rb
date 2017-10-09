class Payment < ApplicationRecord
  # TODO: barely implemented
  belongs_to :payable, polymorphic: true

  enum status: {
    initiated: 1,
    pending: 2,
    completed: 3
  }
end
