class Assignment < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :scores
end
