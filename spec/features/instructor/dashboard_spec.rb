require 'rails_helper'

describe "As an instructor" do
  describe "when I visit my dashboard" do
    it "I can assign myself a cohort" do
      cohort_1 = CensusCohort.create_from_name("1407-BE")
      CensusCohort.create_from_name("1409-BE")
      instructor = User.create(role: "instructor", flock_id: cohort_1.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(instructor)

      visit instructors_dashboard_path
      select('1409-BE', from: 'user[flock_id]')
      click_on "Update Cohort"

      expect(page).to have_content("Successfully assigned cohort.")
      expect(page).to have_content("Current Cohort: 1409-BE")
    end

    it "I can add a cohort" do
        instructor = User.new(role: "instructor")
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(instructor)

        visit instructors_turing_cohorts_path
        fill_in 'cohort_name', with: "1407-BE"
        click_on "Add Cohort"

        expect(page).to have_content("Successfully added 1407-BE")
        expect(page).to have_link("1407-BE")
    end

    it 'I see a list of average students scores' do
      cohort     = CensusCohort.create_from_name("1409-BE")
      instructor = User.create(role: "instructor",
                               flock: cohort.cohort)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(instructor)
      student = User.where(id: 75).first_or_create(id: 75, role: "student")
      CensusUser.new({
                      "first_name" => "Molly",
                      "last_name" => "Brown",
                      "id" => "75"
                     })

      project = Project.create(name: "Black Thursday")
      rc_func = RubricCategory.create(title: "Functionality")
      rc_mech = RubricCategory.create(title: "Mechanics")
      functionality = project.rubrics.create(rubric_category: rc_func,
                                            description: "Functional")
      mechanics = project.rubrics.create(rubric_category: rc_mech,
                                        description: "Mechanical")
      assignment = Assignment.create(user: student,
                                     project: project)
      Score.create(assignment: assignment,
                   rubric: functionality,
                   value: 4)
      Score.create(assignment: assignment,
                   rubric: mechanics,
                   value: 2)
      assignment.update(graded: true)

      visit instructors_dashboard_path

      expect(page).to have_content("3.0")
    end

    it 'I see a list of average student scores for the past week' do
      cohort     = CensusCohort.create_from_name("1409-BE")
      instructor = User.create(role: "instructor",
                               flock: cohort.cohort)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(instructor)
      student = User.where(id: 75).first_or_create(id: 75, role: "student")
      CensusUser.new({
                      "first_name" => "Molly",
                      "last_name" => "Brown",
                      "id" => "75"
                     })

      project = Project.create(name: "Black Thursday")
      rc_func = RubricCategory.create(title: "Functionality")
      rc_mech = RubricCategory.create(title: "Mechanics")
      functionality = project.rubrics.create(rubric_category: rc_func,
                                            description: "Functional")
      mechanics = project.rubrics.create(rubric_category: rc_mech,
                                        description: "Mechanical")
      assignment = Assignment.create(user: student,
                                     project: project,
                                     due_date: Date.yesterday)
      Score.create(assignment: assignment,
                   rubric: functionality,
                   value: 3)
      Score.create(assignment: assignment,
                   rubric: mechanics,
                   value: 3)
      assignment.update(graded: true)

      project_2 = Project.create(name: "HeadCount")
      functionality_2 = project_2.rubrics.create(rubric_category: rc_func,
                                            description: "Functional")
      mechanics_2 = project_2.rubrics.create(rubric_category: rc_mech,
                                        description: "Mechanical")
      assignment = Assignment.create(user: student,
                                     project: project_2,
                                     due_date: Date.today - 14)
      Score.create(assignment: assignment,
                   rubric: functionality_2,
                   value: 4)
      Score.create(assignment: assignment,
                   rubric: mechanics_2,
                   value: 4)
      assignment.update(graded: true)

      visit instructors_dashboard_path

      expect(page).to have_content("3.0")
      expect(page).to have_content("3.5")
    end
  end
end
