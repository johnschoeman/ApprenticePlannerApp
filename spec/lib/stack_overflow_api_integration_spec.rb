require "rails_helper"

RSpec.describe "StackOverflowApiIntegration" do
  describe "#query", :include_stack_overflow_helpers do
    it "returns a hash of tidbit data" do
      stub_api_request
      todays_date = Date.today
      api_integration = StackOverflowApiIntegration.new(todays_date)

      tidbit_data = api_integration.query

      expect_data_to_have_correct_shape(tidbit_data)
    end
  end

  def expect_data_to_have_correct_shape(tidbit_data)
    expect(tidbit_data).to be_instance_of(Hash)
    expect(tidbit_data).to have_key(:title)
    expect(tidbit_data).to have_key(:url)
  end
end
