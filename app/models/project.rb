class Project < ApplicationRecord
  has_many :rubrics
  has_many :rubric_categories, through: :rubrics
  has_many :assignments
  has_many :users, through: :assignments
end
