require "rails_helper"

RSpec.describe "StackOverflowParser" do
  describe "#parse_response" do
    it "takes a response and returns a hash" do
      response = double
      sample_link = Faker::Internet.url
      sample_title = Faker::Lorem.sentence
      sample_parsed_response = {
        "items" => [
          {
            "score" => 0,
            "link" => sample_link,
            "title" => sample_title,
          },
        ],
      }
      allow(response).
        to receive(:parsed_response).and_return(sample_parsed_response)
      parser = StackOverflow::Parser.new

      tidbit_data = parser.parse_response(response)

      expect(tidbit_data[:url]).to eq sample_link
      expect(tidbit_data[:title]).to eq sample_title
    end
  end
end
