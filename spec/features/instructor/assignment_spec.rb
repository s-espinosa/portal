require 'rails_helper'

describe "As an instructor" do
  describe "when I visit an assignment show page" do
    it "I can delete an assignment for a student" do
      census_cohort = CensusCohort.create_from_name("1409-BE")
      project = Project.create(name: "Credit Check")
      student = User.create(role: 'student', id: 75)
      student.assignments.create(project: project)
      instructor = User.create(role: 'instructor', flock_id: census_cohort.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(instructor)

      visit instructors_project_path(project)

      expect(page).to have_content("Molly Brown")

      click_on "unassign"

      expect(current_path).to eq(instructors_project_path(project))
      expect(page).to_not have_content("Molly Brown")
    end
  end

end
