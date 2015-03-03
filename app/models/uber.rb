require "httparty"

class Uber
  include HTTParty
  base_uri "https://api.uber.com/v1"

  attr_reader :token

  def initialize(token)
    @token = token
  end

  def eta
    self.class.get("/estimates/time", {access_token: @token})
  end
end
