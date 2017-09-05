class PrivatePolicy < ApplicationRecord

  belongs_to :instructor_info, foreign_key: 'instructor_id'

  validate on: [:create] do
    errors.add(:base, "Must be created as pending") unless pending
  end
end
