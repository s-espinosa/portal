require 'rails_helper'

describe "As an instructor" do
  describe "when I visit my dashboard page" do
    it "I see a list of students" do
      census_cohort = CensusCohort.create_from_name("1409-BE")
      instructor = User.create(role: 'instructor', flock_id: census_cohort.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(instructor)

      visit instructors_dashboard_path

      expect(page).to have_content("Molly Brown")
    end
  end

  describe 'when I visit a student show page' do
    it 'I see basic student information' do
      census_cohort = CensusCohort.create_from_name("1409-BE")
      instructor = User.create(role: 'instructor', flock_id: census_cohort.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(instructor)

      visit instructors_student_path(75)

      expect(page).to have_content("Molly Brown")
    end

    it 'I can assign a project to a student' do
      census_cohort = CensusCohort.create_from_name("1409-BE")
      instructor = User.create(role: 'instructor', flock_id: census_cohort.id)
      Project.create(name: "Credit Check")
      Project.create(name: "Black Thursday")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(instructor)

      visit instructors_student_path(75)
      select('Black Thursday', from: 'assignment[project_id]')
      click_on("Assign Project")

      expect(page).to have_content("Successfully assigned Black Thursday to Molly Brown")
    end
  end
end

