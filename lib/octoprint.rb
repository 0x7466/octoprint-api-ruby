require 'octoprint/api'
require 'octoprint/errors'

class Octoprint
  attr_reader :url

  def initialize(url, api_key)
    @url = url
    @api_key = api_key
  end

  def api
    @api ||= Octoprint::API.new @url, @api_key
  end
end
