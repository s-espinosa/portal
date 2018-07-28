class CreateUser < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :cohort_name
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :git_hub
      t.integer :census_id
      t.string :image_url
      t.integer :role
      t.string :slack
      t.string :twitter

      t.timestamps null: false
    end
  end
end
