class User < ApplicationRecord
  belongs_to :flock, foreign_key: 'flock_id', class_name: 'TuringCohort', optional: true
  has_many :assignments
  has_many :projects, through: :assignments
  enum role: [:student, :instructor]

  def students
    census_students = CensusService.get_cohort_students(flock_id)
    census_students.map do |student|
      CensusUser.new(student)
    end.sort_by(&:first_name)
  end

  def average_scores
    scores = assignments.map do |assignment|
      assignment.average_score
    end.compact
    total = scores.sum unless scores.empty?
    count = assignments.graded.count
    if count != 0 && total != nil
      total / count
    else
      0
    end
  end

  def trailing_average
    week_ago  = Date.today - 7
    assignments_from_last_week = assignments.where("due_date > ?", week_ago)
    scores = assignments_from_last_week.map do |assignment|
      assignment.average_score
    end.compact
    total = scores.sum unless scores.empty?
    count = assignments_from_last_week.graded.count
    if count != 0 && total != nil
      total / count
    else
      0
    end
  end
end
