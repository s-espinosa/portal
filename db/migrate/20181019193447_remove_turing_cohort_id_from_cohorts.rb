class RemoveTuringCohortIdFromCohorts < ActiveRecord::Migration[5.2]
  def change
    remove_column :turing_cohorts, :census_id
  end
end
