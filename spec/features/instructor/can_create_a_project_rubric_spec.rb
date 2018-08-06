require 'rails_helper'

describe 'As an instructor' do
  describe 'when I visit a project show page' do
    it 'I can create a rubric for that project' do
      instructor = User.new(first_name: "Sal", last_name: "Espinosa", role: "instructor")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(instructor)
      project = Project.create(name: 'Black Thursday')
      RubricCategory.create(title: "Mechanics")

      visit("/instructors/projects/#{project.id}")

      select('Mechanics', from: "rubric[rubric_category_id]")
      fill_in('rubric[description]', with: "Description of Mechanics")
      click_on("Add Rubric Category")

      expect(page).to have_content("Mechanics")
      expect(page).to have_content("Description of Mechanics")
    end
  end
end
