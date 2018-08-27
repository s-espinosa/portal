class AddGradedToAssignments < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :graded, :boolean, default: false
  end
end
