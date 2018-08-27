class AddDueDateToAssignments < ActiveRecord::Migration[5.2]
  def change
    add_column :assignments, :due_date, :date
  end
end
