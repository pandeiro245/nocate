class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.integer :timecrowd_category_id
      t.integer :timecrowd_team_id
      t.integer :user_id
      t.string :notion_database_id

      t.timestamps
    end
  end
end
