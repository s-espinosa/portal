require 'rails_helper'

describe 'CensusFlock' do
  it 'can create a group of students given a cohort id' do
    CensusFlock.create_or_update(46)

    norm = User.find_by(census_id: 586)

    expect(norm.first_name).to eq("Norman")
  end
end
