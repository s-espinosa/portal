class CensusService
  def self.get_cohort_students(census_cohort_id)
    response = conn.get do |req|
      req.url '/api/v1/users/by_cohort'
      req.params['access_token'] = token
      req.params['cohort_id'] = census_cohort_id
    end
    JSON.parse(response.body)
  end

  def self.get_cohorts
    response = conn.get do |req|
      req.url '/api/v1/cohorts'
      req.params['access_token'] = token
    end
    JSON.parse(response.body)
  end

  def self.find_by_census_id(id)
    response = conn.get do |req|
      req.url "/api/v1/users/#{id}"
      req.params['access_token'] = token
    end
    census_user = JSON.parse(response.body)
    census_user["cohort"] = {"name" => census_user["cohort"], "id" => census_user["cohort_id"]}
    census_user.delete("cohort_id")
    census_user
  end

  private
  def self.conn
    Faraday.new(:url => 'https://login.turing.io/') do |faraday|
      faraday.request  :url_encoded
      faraday.adapter  Faraday.default_adapter
    end
  end

  def self.token
    response = conn.post do |req|
      req.url '/oauth/token'
      req.params['grant_type'] = 'client_credentials'
      req.params['client_id'] = ENV['CENSUS_ID']
      req.params['client_secret'] = ENV['CENSUS_SECRET']
    end
    JSON.parse(response.body)["access_token"]
  end
end
