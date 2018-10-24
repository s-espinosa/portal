require 'rails_helper'

describe "As an instructor" do
  it "I can create a new project" do
    instructor = User.new(role: "instructor")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(instructor)
    project_category = ProjectCategory.create(title: "Project")

    visit('/instructors/projects/new')

    fill_in('project[name]', with: "New Name")
    select('Project', from: "project[project_category_id]")
    click_on("Create Project")

    expect(current_path).to eq("/instructors/projects/#{Project.last.id}")
    expect(page).to have_content("New Name successfully created.")
    within "h2" do
      expect(page).to have_content("New Name")
    end
  end
end
