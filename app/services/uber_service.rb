class UberService
  include HTTParty
  base_uri "https://api.uber.com/v1"

  attr_reader :token

  def initialize(token)
    @token = token
    self.class.headers authorization_header
  end

  def eta_times(options = {})
    self.class.get("/estimates/time", query: options)["times"]
  end

  private

  def authorization_header
    { "Authorization" => "Bearer #{token}" }
  end
end
