class CensusUser
  def self.create_or_update(census_user)
    if User.find_by(census_id: census_user['id'])
      user = update_census_user(census_user)
    else
      user = create_census_user(census_user)
    end
    user
  end

  def self.update_census_user(census_user)
    user = User.find_by(census_id: census_user['id'])
    user = update_attributes(user, census_user)
    user.save
    user
  end

  def self.create_census_user(census_user)
    user = User.new
    user = update_attributes(user, census_user)
    user.save
    user
  end

  def self.update_attributes(user, census_user)
    user.turing_cohort_id  = find_cohort(census_user['cohort'])
    user.email             = census_user['email']
    user.first_name        = census_user['first_name']
    user.last_name         = census_user['last_name']
    user.git_hub           = census_user['git_hub']
    user.census_id         = census_user['id']
    user.image_url         = census_user['image_url']
    user.role              = determine_role(census_user['roles'])
    user.slack             = census_user['slack']
    user.twitter           = census_user['twitter']
    user
  end

  def self.determine_role(census_roles)
    roles = census_roles.map do |role|
      role['name']
    end

    if roles.include?("staff")
      "instructor"
    else
      "student"
    end
  end

  def self.find_cohort(census_cohort)
    cohort = TuringCohort.where(census_id: census_cohort['id'], name: census_cohort["name"])
      .first_or_create do |c|
      c.census_id  = census_cohort["id"]
      c.name       = census_cohort["name"]
    end
    cohort.id
  end

end
