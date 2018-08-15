require 'rails_helper'

describe "As an instructor" do
  describe "when I visit my dashboard" do
    it "I can assign myself a cohort" do
      TuringCohort.create(name: "1808-BE")
      TuringCohort.create(name: "1806-BE")
      instructor = User.create(first_name: "Sal", last_name: "Espinosa", role: "instructor")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(instructor)

      visit instructors_dashboard_path
      select('1808-BE', from: 'user[flock_id]')
      click_on "Update Cohort"

      expect(page).to have_content("Successfully assigned cohort.")
      expect(page).to have_content("Current Cohort: 1808-BE")
    end

    it "I can import a list of cohorts" do
      instructor = User.create(first_name: "Sal", last_name: "Espinosa", role: "instructor")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(instructor)

      visit instructors_dashboard_path
      click_on "Import Cohorts"

      expect(page).to have_content("Successfully imported cohorts from Census.")
    end
  end
end
