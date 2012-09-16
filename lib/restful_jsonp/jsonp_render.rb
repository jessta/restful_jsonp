
module RestfulJSONP

  def self.included(klass)
    klass.class_eval do
      # Don't return error HTTP status codes in JSON-P (4xx, 5xx)
      # and Flash requests.
      define_method(:render) do |*args|
        status = args.clone.extract_options![:status] || response.status

        if (jsonp_request? or flash_request?) and http_status_incompatible?(status)
          # Illegal response code
          args.last[:status] = 200 if args.last.is_a? Hash
        end
        
        super
      end
    end
  end

  protected

  def jsonp_request?
    request.format == :json and params[:callback] and not request.xhr?
  end

  def flash_request?
    params[:as3] == 't'
  end

  def http_status_incompatible?(status)
    if status.is_a?(Symbol)
      status = Rack::Utils::SYMBOL_TO_STATUS_CODE[status]
    end

    # 4xx or 5xx status code
    status and [4, 5].include?(status / 100) 
  end

end
