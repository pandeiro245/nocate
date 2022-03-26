# frozen_string_literal: true

class Api::Timecrowd
  def create_category(team_id, title, parent_id: nil, color: nil, position: nil)
    params = { category: { title: title } }
    params[:category][:parent_id] = parent_id if parent_id.present?
    params[:category][:color] = color if color.present?
    params[:category][:position] = color if position.present?
    api_post("/api/v1/teams/#{team_id}/categories", params)
  end

  def client
    @client ||= OAuth2::AccessToken.new(
      OAuth2::Client.new(
	ENV.fetch('TIMECROWD_APP_ID') { Rails.application.credentials.timecrowd[:app_id] },
	ENV.fetch('TIMECROWD_SECRET') { Rails.application.credentials.timecrowd[:secret] },
	site: ENV.fetch('TIMECROWD_SITE', 'https://timecrowd.net')
      ), ENV['TIMECROWD_TOKEN']
    )
  end

  def api_get(path, params = {})
    api_request(:get, path, params)
  end

  def api_post(path, params = {})
    api_request(:post, path, params)
  end

  def api_put(path, params = {})
    api_request(:put, path, params)
  end

  def api_patch(path, params = {})
    api_request(:patch, path, params)
  end

  def api_delete(path, params = {})
    api_request(:delete, path, params)
  end

  def api_request(method, path, params = {})
    client.public_send(method, path, body: params).parsed
  end
end
