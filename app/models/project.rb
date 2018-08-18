class Project < ApplicationRecord
  has_many :rubrics
  has_many :rubric_categories, through: :rubrics
  has_many :assignments
  has_many :users, through: :assignments

  def ungraded_assignments
    assignments.joins('LEFT JOIN scores
                      ON scores.assignment_id = assignments.id')
  end
end
