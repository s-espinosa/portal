require 'rails_helper'

describe User do
  it 'can determine the average score of all its assignments' do
    student = User.create(first_name: "Student",
                          last_name: "One",
                          role: "student")
    project_1 = Project.create(name: "Black Thursday")
    rc_func = RubricCategory.create(title: "Functionality")
    rc_mech = RubricCategory.create(title: "Mechanics")
    functionality = project_1.rubrics.create(rubric_category: rc_func,
                                             description: "Functional")
    mechanics = project_1.rubrics.create(rubric_category: rc_mech,
                                         description: "Mechanical")
    assignment = Assignment.create(user: student,
                                   project: project_1)
    Score.create(assignment: assignment,
                 rubric: functionality,
                 value: 4)
    Score.create(assignment: assignment,
                 rubric: mechanics,
                 value: 2)


    project_2 = Project.create(name: "Sorting Cards")
    rc_func = RubricCategory.create(title: "Functionality")
    rc_mech = RubricCategory.create(title: "Mechanics")
    functionality = project_2.rubrics.create(rubric_category: rc_func,
                                             description: "Functional")
    mechanics = project_2.rubrics.create(rubric_category: rc_mech,
                                         description: "Mechanical")
    assignment = Assignment.create(user: student,
                                   project: project_2)
    Score.create(assignment: assignment,
                 rubric: functionality,
                 value: 4)
    Score.create(assignment: assignment,
                 rubric: mechanics,
                 value: 4)

    expect(student.average_scores).to eq(3.5)
  end
end
