class CensusFlock
  def self.create_or_update(census_cohort_id)
    students = CensusService.get_cohort_students(census_cohort_id)
    create_users(students)
  end

  def self.create_users(students)
    students.map do |student|
      User.where(id: student["id"])
        .first_or_create(id: student["id"])
    end
  end
end
