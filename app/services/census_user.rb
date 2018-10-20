class CensusUser
  def self.find(id)
    census_info = CensusService.find_by_census_id(id)
    create(census_info)
  end

  def self.create(student)
    User.where(id: student["id"])
      .first_or_create(id: student["id"])
    CensusUser.new(student)
  end

  def self.create_all(students)
    students.map do |student|
      CensusUser.create(student)
    end.sort_by(&:first_name)
  end

  attr_reader :first_name

  def initialize(info)
    @first_name = info["first_name"]
    @last_name  = info["last_name"]
    @cohort_id  = info["cohort_id"]
    @user       = User.find(info["id"])
  end

  def full_name
    @first_name + " " + @last_name
  end

  def average_scores
    @user.average_scores
  end

  def trailing_average
    @user.trailing_average
  end

  def assignments
    @user.assignments
  end

  def id
    @user.id
  end

  def projects
    @user.projects
  end
end
