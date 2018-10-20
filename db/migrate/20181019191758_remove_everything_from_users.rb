class RemoveEverythingFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :email
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :git_hub
    remove_column :users, :census_id
    remove_column :users, :image_url
    remove_column :users, :slack
    remove_column :users, :twitter
    remove_column :users, :turing_cohort_id
  end
end
