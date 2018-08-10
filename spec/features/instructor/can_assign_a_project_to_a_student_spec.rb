require 'rails_helper'

describe "As an instructor" do
  describe "when I visit my dashboard page" do
    it "I see a list of students" do
      instructor = User.new(first_name: "Sal", last_name: "Espinosa", role: "instructor")
      User.new(first_name: "George", last_name: "Jefferson", role: "student")
      User.new(first_name: "Geneveve", last_name: "Jackson", role: "student")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(instructor)

      visit instructors_dashboard_path

      expect(page).to have_content("George Jefferson")
      expect(page).to have_content("Geneveve Jackson")
    end
  end
end

