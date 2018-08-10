class CreateCohorts < ActiveRecord::Migration[5.2]
  def change
    create_table :cohorts do |t|
      t.string :name
      t.string :census_id

      t.timestamps null: false
    end
  end
end
