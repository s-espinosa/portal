require 'rails_helper'

describe User do
  it 'can determine the average score of all its assignments' do
    student = User.create(role: "student")
    project_1 = Project.create(name: "Black Thursday")
    rc_func = RubricCategory.create(title: "Functionality")
    rc_mech = RubricCategory.create(title: "Mechanics")
    functionality_1 = project_1.rubrics.create(rubric_category: rc_func,
                                             description: "Functional")
    mechanics_1 = project_1.rubrics.create(rubric_category: rc_mech,
                                         description: "Mechanical")
    assignment_1 = Assignment.create(user: student,
                                   project: project_1)
    Score.create(assignment: assignment_1,
                 rubric: functionality_1,
                 value: 4)
    Score.create(assignment: assignment_1,
                 rubric: mechanics_1,
                 value: 2)
    assignment_1.update(graded: true)


    project_2 = Project.create(name: "Sorting Cards")
    functionality_2 = project_2.rubrics.create(rubric_category: rc_func,
                                             description: "Functional")
    mechanics_2 = project_2.rubrics.create(rubric_category: rc_mech,
                                         description: "Mechanical")
    assignment_2 = Assignment.create(user: student,
                                   project: project_2)
    Score.create(assignment: assignment_2,
                 rubric: functionality_2,
                 value: 4)
    Score.create(assignment: assignment_2,
                 rubric: mechanics_2,
                 value: 4)
    assignment_2.update(graded: true)

    expect(student.average_scores).to eq(3.5)
  end

  it 'can determine the average score of assignments for the past week' do
    student = User.create(role: "student")
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
    assignment_2 = Assignment.create(user: student,
                                   project: project_2,
                                   due_date: Date.today - 14)
    Score.create(assignment: assignment_2,
                 rubric: functionality_2,
                 value: 4)
    Score.create(assignment: assignment_2,
                 rubric: mechanics_2,
                 value: 4)
    assignment_2.update(graded: true)

    expect(student.average_scores).to eq(3.5)
    expect(student.trailing_average).to eq(3.0)
  end
end
