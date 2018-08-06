class Rubric < ApplicationRecord
  belongs_to :project
  belongs_to :rubric_category
end
