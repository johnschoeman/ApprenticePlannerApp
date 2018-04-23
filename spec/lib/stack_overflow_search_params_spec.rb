require "rails_helper"

RSpec.describe "StackOverflowSearchParams" do
  it "intializes with a base query" do
    date = Time.zone.today
    from_date = date_to_epoch_string(date - 365.days)
    to_date = date_to_epoch_string(date - 364.days)

    base_query = {
      page: 1,
      page_size: 100,
      from_date: from_date,
      to_date: to_date,
      order: "desc",
      sort: "creation",
      min: from_date,
      max: to_date,
      tagged: "elixir",
      site: "stackoverflow",
    }

    search_params = StackOverflow::SearchParams.new

    expect(search_params.to_h).to eq(base_query)
  end

  describe "#params" do
    it "returns an instance of a hash" do
      search_params = StackOverflow::SearchParams.new
      search_params_hash = search_params.to_h

      expect(search_params_hash).to be_instance_of(Hash)
    end
  end

  def date_to_epoch_string(date)
    date.to_time.to_i.to_s
  end
end
