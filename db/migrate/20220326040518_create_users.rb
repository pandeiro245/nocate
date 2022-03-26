class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :timecrowd_token
      t.string :notion_token
      t.integer :team_id

      t.timestamps
    end
  end
end
