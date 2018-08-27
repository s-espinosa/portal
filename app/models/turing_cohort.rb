class TuringCohort < ApplicationRecord
  has_many :students, foreign_key: 'turing_cohort_id', class_name: 'User'
  has_many :teachers, foreign_key: 'flock_id', class_name: 'User'

  def assign_project(project, due_date)
    students.each do |student|
      student.assignments.create(project: project, due_date: due_date)
    end
  end
end
