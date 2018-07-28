class User < ApplicationRecord
  enum role: [:student, :instructor]

  def self.create_from_census(census_user)
    if User.find_by(census_id: census_user.id)
      user = update_census_user(census_user)
    else
      user = create_census_user(census_user)
    end
    user
  end

  def self.update_census_user(census_user)
    user = User.find_by(census_id: census_user.id)
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
    user.cohort_name = census_user.cohort_name
    user.email       = census_user.email
    user.first_name  = census_user.first_name
    user.last_name   = census_user.last_name
    user.git_hub     = census_user.git_hub
    user.census_id   = census_user.id
    user.image_url   = census_user.image_url
    user.role        = determine_role(census_user)
    user.slack       = census_user.slack
    user.twitter     = census_user.twitter
    user
  end

  def self.determine_role(census_user)
    if census_user.roles.include?("staff")
      "instructor"
    else
      "student"
    end
  end
end
