module StackOverflow
  class Service
    include HTTParty
    base_uri "api.stackexchange.com/2.2"

    def query(query_params)
      response = query_endpoint(query_params)
      handle_response(response)
    end

    private

    def query_endpoint(query_params)
      params = query_params.to_h
      options = { query: params }
      search(options)
    end

    def search(options)
      self.class.get("/search", options)
    end

    def handle_response(response)
      if response.success?
        response
      elsif response.client_error?
        return_error(response)
      elsif response.server_error?
        return_error(response)
      else
        raise UnhandledResponseError
      end
    end

    def return_error(response)
      raise StandardError.new(response.parsed_response)
    end

    UnhandledResponseError = Class.new(StandardError)
  end
end
