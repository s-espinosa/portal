class CreateRubricCategory < ActiveRecord::Migration[5.2]
  def change
    create_table :rubric_categories do |t|
      t.string :title
    end
  end
end
