class CreateTuringCohorts < ActiveRecord::Migration[5.2]
  def change
    create_table :turing_cohorts do |t|
      t.string :name
      t.string :census_id

      t.timestamps null: false
    end
  end
end
