class PrivatePolicy < ApplicationRecord

  # Not actually used yet. The design is that the private policy of an instructor
  # is version-controlled, and must be verified before being used.
  # When the policy is changed, all "confirmed" transaction should be changed to
  # "initiated".

  belongs_to :instructor_info, foreign_key: 'instructor_id'

  validate on: [:create] do
    errors.add(:base, "Must be created as pending") unless pending
  end
end
