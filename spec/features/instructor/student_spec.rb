require 'rails_helper'

describe 'As an instructor' do
  describe 'when I visit a student show page' do
    it 'I can update that user from Census' do
      cohort = TuringCohort.create(name: "1808-BE")
      instructor = User.create(first_name: "Instructor", last_name: "One", role: "instructor", flock: cohort)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(instructor)
      student = User.create(first_name: "Sal", last_name: "Espinsoa", role: "student", turing_cohort: cohort, census_id: 24)

      visit(instructors_student_path(student))
      click_on "Update Student from Census"

      expect(page).to have_content("Successfully updated Sal Espinosa from Census.")
      expect(User.find(student.id).cohort.name).to eq("1602-BE")
    end
  end
end
