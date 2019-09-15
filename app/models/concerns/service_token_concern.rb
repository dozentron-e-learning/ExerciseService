module ServiceTokenConcern
  extend ActiveSupport::Concern

  AUTH_SERVICE_URL = Rails.application.config.service_urls.auth_service
  SERVICE_TOKEN_URL = "#{AUTH_SERVICE_URL}/api/v1/auths/token/service"

  def service_token(sub, iss, data, token=self.auth_token)
    service_t = RestClient::Request.execute(
        method:  :get,
        url:     SERVICE_TOKEN_URL,
        payload: {sub: sub, iss: iss, data: data}.to_json,
        headers: {
          Authorization: "Bearer #{token}",
          content_type: 'application/json'
        }
    )
    JSON.parse(service_t)['data']
  end
end