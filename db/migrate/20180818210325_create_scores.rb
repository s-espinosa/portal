class CreateScores < ActiveRecord::Migration[5.2]
  def change
    create_table :scores do |t|
      t.integer :value
      t.string :note
      t.references :assignment, foreign_key: true
      t.references :rubric, foreign_key: true

      t.timestamps null: false
    end
  end
end
