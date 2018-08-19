require 'rails_helper'

describe 'As an instructor' do
  describe 'when I visit the project index' do
    it 'I can grade the project of a student' do
      instructor = User.create(first_name: "Sal", last_name: "Espinosa", role: "instructor")
      student_1  = User.create(first_name: "student", last_name: "one", role: "student")
      student_2  = User.create(first_name: "student", last_name: "two", role: "student")

      bt = Project.create(name: "Black Thursday")

      mechanics     = RubricCategory.create(title: "Mechanics")
      functionality = RubricCategory.create(title: "Functionality")
      design        = RubricCategory.create(title: "Design")

      mech = bt.rubrics.create(rubric_category: mechanics)
      func = bt.rubrics.create(rubric_category: functionality)
      des  = bt.rubrics.create(rubric_category: design)

      assignment_1 = student_1.assignments.create(project: bt)
      student_2.assignments.create(project: bt)

      assignment_1.scores.create(rubric: mech, value: 3, note: "Hey!")
      assignment_1.scores.create(rubric: func, value: 2, note: "Hey!")
      assignment_1.scores.create(rubric: des, value: 4, note: "Hey!")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(instructor)

      visit instructors_projects_path
      click_on "Black Thursday"
      click_on "student two"

      fill_in("assessment[#{mech.id}][value]", with: "3")
      fill_in("assessment[#{mech.id}][note]", with: "HEY!")
      fill_in("assessment[#{func.id}][value]", with: "2")
      fill_in("assessment[#{func.id}][note]", with: "HEY YOU!")
      fill_in("assessment[#{des.id}][value]", with: "3")
      fill_in("assessment[#{des.id}][note]", with: "HEY YOU OVER THERE!")
      click_on "Save Scores"

      expect(current_path).to eq(instructors_project_path(bt))
      expect(student_2.assignments.last.scores.count).to eq(3)
    end
  end
end
