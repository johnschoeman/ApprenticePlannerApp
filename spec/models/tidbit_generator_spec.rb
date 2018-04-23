require "rails_helper"

RSpec.describe "TidbitGenerator" do
  describe ".generate", :include_stack_overflow_helpers do
    it "returns a tidbit" do
      stub_api_request
      todays_date = Date.today

      tidbit = TidbitGenerator.generate(todays_date)

      expect(tidbit).to be_an_instance_of(Tidbit)
    end
  end
end
