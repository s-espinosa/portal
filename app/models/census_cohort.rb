class CensusCohort
  def self.update_all
    cohorts = CensusService.get_cohorts
    create_cohorts(cohorts)
  end

  def self.create_cohorts(cohorts)
    cohorts.map do |cohort|
      TuringCohort.where(id: cohort[:id])
        .first_or_create do |c|
          c.census_id = cohort["id"]
          c.name      = cohort["name"]
      end
    end
  end
end
