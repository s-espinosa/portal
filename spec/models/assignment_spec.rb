require 'rails_helper'

describe Assignment do
  it 'can calculate average scores' do
    student = User.create(first_name: "Student",
                          last_name: "One",
                          role: "student")
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

    expect(assignment.average_score).to eq(3.0)
  end
end
