class Assignment < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :scores

  def average_score
    scores.average(:value)
  end

  def self.graded
    where(graded: true)
  end
end
