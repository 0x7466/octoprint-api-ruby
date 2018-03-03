class Octoprint
  class GenericError < StandardError
  end

  class ResponseError < GenericError
    def initialize(status_code, response_body)
      @status_code = status_code
      @response_body = response_body

      super([@status_code, @response_body].join(': '))
    end
  end
end
