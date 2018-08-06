class Project < ApplicationRecord
  has_many :rubrics
  has_many :rubric_categories, through: :rubrics
end
