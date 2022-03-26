# frozen_string_literal: true

class Sync
  def exec
    id = ENV['NOTION_DATABASE_ID']
    parent_id = 1115473
    team_id = 31801
    color = 4
    user_id = 67
    notion = Api::Notion.new
    client = notion.client
    notion.select_database(id).each do |db|
      title = db['properties']['Name']['title'].first['text']['content']

      next if db['properties']['timecrowd_category_id']['number'].present?

      puts title

      category_id = Api::Timecrowd.new.create_category(team_id, title, parent_id: parent_id, color: color)['id']


      # category = Category.find_or_initialize_by(
      #   timecrowd_category_id: id,
      # )
      # category.timecrowd_team_id = team_id
      # category.user_id = user_id
      # category.notion_database_id = db['id']
      # category.save!


      properties = {
        'timecrowd_category_id': category_id
      }
      client.update_page(page_id: db['id'], properties: properties)
    end
  end
end
