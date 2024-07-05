# frozen_string_literal: true

module RequestHelpers
  def json_headers
    {
      "ACCEPT" => "application/json",
      "HTTP_ACCEPT" => "application/json",
    }
  end

  def auth_headers(recruiter)
    headers = json_headers
    post "/v1/recruiters/sign_in", params: { email: recruiter.email, password: recruiter.password }, headers: headers
    headers["Authorization"] = response.headers["Authorization"]
    headers
  end
end

RSpec.configure do |config|
  config.include(RequestHelpers, type: :request)
end
