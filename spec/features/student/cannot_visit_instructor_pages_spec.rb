require 'rails_helper'

describe 'As a student' do
  describe 'when I visit instructor pages' do
    it 'I see an error' do
      user = User.create(first_name: 'George', last_name: 'Jefferson', role: 'student')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      expect do
        visit instructors_dashboard_path
      end.to raise_error('Not Found')

      expect do
        visit instructors_projects_path
      end.to raise_error('Not Found')

      expect do
        visit new_instructors_project_path
      end.to raise_error('Not Found')
    end
  end
end
