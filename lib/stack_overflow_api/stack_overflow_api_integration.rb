class StackOverflowApiIntegration
  def initialize(date)
    @date = date
    @parser = StackOverflow::Parser.new
    @query_params = StackOverflow::SearchParams.new
    @service = StackOverflow::Service.new
    @response = nil
    @parsed_response = nil
  end

  def query
    set_up_params
    query_service
    parse_response
  end

  private

  def set_up_params
    @query_params.set_date(@date)
  end

  def query_service
    @response = @service.query(@query_params)
  end

  def parse_response
    @parsed_response = @parser.parse_response(@response)
  end
end
