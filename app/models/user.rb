class User < ApplicationRecord
  belongs_to :turing_cohort, optional: true
  belongs_to :flock, foreign_key: 'flock_id', class_name: 'TuringCohort', optional: true
  has_many :students, through: :flock
  has_many :assignments
  has_many :projects, through: :assignments
  enum role: [:student, :instructor]

  def cohort
    turing_cohort
  end

  def full_name
    "#{first_name} #{last_name}"
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

  def self.create_from_census(census_user, census_cohort)
    if User.find_by(census_id: census_user.id)
      user = update_census_user(census_user, census_cohort)
    else
      user = create_census_user(census_user, census_cohort)
    end
    user
  end

  def self.update_census_user(census_user, census_cohort)
    user = User.find_by(census_id: census_user.id)
    user = update_attributes(user, census_user, census_cohort)
    user.save
    user
  end

  def self.create_census_user(census_user, census_cohort)
    user = User.new
    user = update_attributes(user, census_user, census_cohort)
    user.save
    user
  end

  def self.update_attributes(user, census_user, census_cohort)
    user.turing_cohort_id  = find_cohort(census_cohort)
    user.email             = census_user.email
    user.first_name        = census_user.first_name
    user.last_name         = census_user.last_name
    user.git_hub           = census_user.git_hub
    user.census_id         = census_user.id
    user.image_url         = census_user.image_url
    user.role              = determine_role(census_user)
    user.slack             = census_user.slack
    user.twitter           = census_user.twitter
    user
  end

  def self.determine_role(census_user)
    if census_user.roles.include?("staff")
      "instructor"
    else
      "student"
    end
  end

  def self.find_cohort(census_cohort)
    cohort = TuringCohort.where(census_id: census_cohort["id"], name: census_cohort["name"])
      .first_or_create do |c|
        c.census_id  = census_cohort["id"]
        c.name       = census_cohort["name"]
      end
    cohort.id
  end
end
