class TuringCohort < ApplicationRecord
  has_many :teachers, foreign_key: 'flock_id', class_name: 'User'
end
