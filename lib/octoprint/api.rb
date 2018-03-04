require 'faraday'
require 'json'

class Octoprint
  class API
    def initialize(url, api_key)
      @url = url
      @api_key = api_key
    end

    def method_missing(name, **args, &block)
      super unless name_qualified_for_api_request?(name)

      http_verb = args[:method] || :get
      response = _connection.public_send http_verb, generate_api_path(name)

      super if response.status == 404
      raise Octoprint::ResponseError.new(response.status, response.body) unless (200..299).include?(response.status)

      parse(response.body)
    end

    def respond_to_missing?(method_name, include_private = false)
      return super unless name_qualified_for_api_request?(method_name)
      
      unless super
        response = _connection.get(generate_api_path(method_name))
        return response.status != 404
      end

      super
    end
    
    private

    def _connection
      @_connection ||= Faraday.new url: @url do |conn|
        conn.headers['X-Api-Key'] = @api_key
        conn.headers['Content-Type'] = 'application/json'
        conn.adapter ::Faraday.default_adapter
      end
    end

    def parse(value)
      JSON.parse value
    end

    def convert_method_name_into_http_path(name)
      name.to_s.gsub('_', '/')
    end

    def generate_api_path(method_name)
      path = convert_method_name_into_http_path(method_name)
      ['api', path].join('/')
    end

    def name_qualified_for_api_request?(name)
      # Not qualified if _ at the beginning
      (name =~ /\A_\w*\z/).nil?
    end
  end
end
