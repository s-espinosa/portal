class CensusCohort
  def self.create_from_name(name)
    cohorts     = CensusService.get_cohorts
    cohort_info = filter_cohorts(cohorts, name)

    if cohort_info.empty?
      nil
    else
      create_cohort_from_census(cohort_info)
    end
  end

  def self.find(id)
    cohort = TuringCohort.find(id)
    CensusCohort.new(cohort)
  end

  def self.all
    cohorts = TuringCohort.all
    cohorts.map { |cohort| CensusCohort.new(cohort) }
  end

  attr_reader :cohort

  def initialize(cohort)
    @cohort = cohort
  end

  def students
    census_users = CensusService.get_cohort_students(self.id)
    census_users.map do |user|
      CensusUser.new(user)
    end
  end

  def name
    @cohort.name
  end

  def id
    @cohort.id
  end

  def assign_project(project, due_date)
    students.each do |student|
      student.assignments.create(project: project, due_date: due_date)
    end
  end

  private
  def self.filter_cohorts(cohorts, name)
    cohorts.select do |cohort|
      cohort["name"] == name.upcase
    end
  end

  def self.create_cohort_from_census(cohort_info)
    formatted = cohort_info
                  .first
                  .except("start_date", "status")

    cohort = TuringCohort
      .where(id: formatted["id"])
      .first_or_create(formatted)
    census_cohort = CensusCohort.new(cohort)

    CensusFlock.create_or_update(cohort.id)
    census_cohort
  end
end
