
module RestfulJSONP
  class StatusCodes
    # Flash requires 200 status codes just like JSONP
    JSONP_PARAMS = ['callback', 'as3']

    def initialize(app, routes=[])
      @app = app
      @routes = routes
    end

    def call(env)
      @env = env
      @req = Rack::Request.new(@env)

      status, headers, response = @app.call(@env)

      if enabled_route? and jsonp_request?
        # Allow Rack::JSONP to set the callback string when we have
        # a 204 No Content response
        headers['Content-Type'] = 'application/json'

        unless compatible_status?(status)
          Rails.logger.info('RestfulJSONP: Rewriting status code for JSON-P compatibility')
          status = 200
        end
      end

      [status, headers, response]
    end

    def compatible_status?(status)
      # Some 2xx responses don't work; set them all to 200
      status == 200 or [1, 3].include?(status / 100)
    end

    def jsonp_request?
      JSONP_PARAMS.any? {|p| @req.params.has_key?(p)}
    end

    def enabled_route?
      @routes.each do |pattern|
        return true if pattern.match(@req.path)
      end

      false
    end
  end
end
