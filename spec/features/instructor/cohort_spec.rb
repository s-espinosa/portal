require 'rails_helper'

describe 'As an Instructor' do
  describe 'when I visit the cohort index' do
    it 'I see a list of cohorts' do
      instructor = User.create(role: 'instructor')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(instructor)
      TuringCohort.create(name: "1806-BE")
      TuringCohort.create(name: "1808-BE")

      visit instructors_turing_cohorts_path

      expect(page).to have_content("1806-BE")
      expect(page).to have_content("1808-BE")
    end
  end

  describe 'when I visit the cohort show' do
    it 'I can assign a project to an entire cohort' do
      Project.create(name: "Black Thursday")
      census_cohort = CensusCohort.create_from_name("1409-BE")
      instructor = User.create(role: 'instructor', flock_id: census_cohort.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(instructor)

      visit instructors_turing_cohort_path(census_cohort.id)

      select("Black Thursday", from: 'project_id')
      click_on("Assign Project to Cohort")

      expect(User.find(75).assignments.count).to eq(1)
      expect(page).to have_content("Successfully assigned Black Thursday to 1409-BE")
    end
  end
end
