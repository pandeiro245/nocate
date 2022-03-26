# frozen_string_literal: true

class Api::Notion
    def databases_list
      client.databases_list
    end

    def select_database(parent_id)
      # TODO: has_more
      client.database_query(database_id: parent_id)['results']
    end

    def find_database(id)
      client.database(database_id: id)
    end

    def find_page(id)
      client.page(page_id: id)
    end

    def update_page(id, properties)
      client.update_page(page_id: id, properties: properties)
    end

    def client
      @client ||= Notion::Client.new(token: ENV['NOTION_TOKEN'])
    end
  end
