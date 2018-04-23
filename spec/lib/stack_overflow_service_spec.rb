require "rails_helper"

RSpec.describe "StackOverflowService" do
  describe "#query", :include_stack_overflow_helpers do
    it "returns a response" do
      stub_api_request
      params = StackOverflow::SearchParams.new
      service = StackOverflow::Service.new

      response = service.query(params)

      expect(response).to be_an_instance_of(HTTParty::Response)
    end

    it "handles bad responses" do
      stub_request(:get, /api.stackexchange/).
        to_return(status: [500, "Internal Server Error"], body: "error message")
      service = StackOverflow::Service.new
      params = StackOverflow::SearchParams.new

      expect { service.query(params) }.
        to raise_error(StandardError, "error message")
    end
  end
end
