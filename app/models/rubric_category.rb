class RubricCategory < ApplicationRecord
  has_many :rubrics
  has_many :projects, through: :rubrics
end
