require 'rails_helper'

describe 'CensusFlock' do
  it 'can create a group of students given a cohort id' do
    CensusFlock.create_or_update(4)

    expect(User.count).to eq(2)
  end
end
