require 'rails_helper'

describe "As an instructor" do
  describe "when I visit my dashboard page" do
    it "I see a list of students" do
      cohort     = TuringCohort.create(name: "1808-BE")
      instructor = User.create(first_name: "Sal", last_name: "Espinosa", role: "instructor", flock: cohort)
      User.create(first_name: "George", last_name: "Jefferson", role: "student", turing_cohort: cohort)
      User.create(first_name: "Geneveve", last_name: "Jackson", role: "student", turing_cohort: cohort)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(instructor)

      visit instructors_dashboard_path

      expect(page).to have_content("George Jefferson")
      expect(page).to have_content("Geneveve Jackson")
    end
  end

  describe 'when I visit a student show page' do
    it 'I see basic student information' do
      cohort     = TuringCohort.create(name: "1808-BE")
      instructor = User.create(first_name: "Sal", last_name: "Espinosa", role: "instructor", flock: cohort)
      student_1  = User.create(first_name: "George", last_name: "Jefferson", role: "student", turing_cohort: cohort)
      User.create(first_name: "Geneveve", last_name: "Jackson", role: "student", turing_cohort: cohort)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(instructor)

      visit instructors_student_path(student_1)

      expect(page).to have_content("George Jefferson")
      expect(page).to_not have_content("Geneveve Jackson")
    end

    it 'I can assign a project to a student' do
      cohort     = TuringCohort.create(name: "1808-BE")
      student    = User.create(first_name: "George", last_name: "Jefferson", role: "student", turing_cohort: cohort)
      instructor = User.create(first_name: "Sal", last_name: "Espinosa", role: "instructor", flock: cohort)
      Project.create(name: "Credit Check")
      Project.create(name: "Black Thursday")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(instructor)

      visit instructors_student_path(student)
      select('Black Thursday', from: 'assignment[project_id]')
      click_on("Assign Project")

      expect(page).to have_content("Successfully assigned Black Thursday to George Jefferson")
    end
  end
end

