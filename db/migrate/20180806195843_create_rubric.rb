class CreateRubric < ActiveRecord::Migration[5.2]
  def change
    create_table :rubrics do |t|
      t.references :rubric_category, foreign_key: true
      t.references :project, foreign_key: true
      t.string :description
    end
  end
end
