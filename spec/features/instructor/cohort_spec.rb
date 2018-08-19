require 'rails_helper'

describe 'As an Instructor' do
  describe 'when I visit the cohort index' do
    it 'I see a list of cohorts' do
      instructor = User.create(first_name: 'Sal', last_name: 'Espinosa', role: 'instructor')
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
      cohort = TuringCohort.create(name: "1808-BE")
      instructor = User.create(first_name: 'Sal', last_name: 'Espinosa', role: 'instructor')
      student_1 = User.create(first_name: "Student", last_name: "One", role: "student", turing_cohort: cohort)
      student_2 = User.create(first_name: "Student", last_name: "Two", role: "student", turing_cohort: cohort)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(instructor)

      visit instructors_turing_cohort_path(cohort)

      select("Black Thursday", from: 'project_id')
      click_on("Assign Project to Cohort")

      expect(student_1.assignments.count).to eq(1)
      expect(student_2.assignments.count).to eq(1)
      expect(page).to have_content("Successfully assigned Black Thursday to 1808-BE")
    end
  end
end
