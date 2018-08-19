class Score < ApplicationRecord
  belongs_to :rubric
  belongs_to :assignment
end
