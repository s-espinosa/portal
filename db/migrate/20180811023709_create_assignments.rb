class CreateAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments do |t|
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true
      t.string :link

      t.timestamps null: false
    end
  end
end
