class RemoveCohortNameFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :cohort_name, :string
  end
end
