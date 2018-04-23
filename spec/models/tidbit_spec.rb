require "rails_helper"

RSpec.describe "Tidbit" do
  it "responds to title and url" do
    tidbit_data = { "url" => "https://thoughtbot.com", "title" => "thoughtbot" }

    tidbit = Tidbit.new(tidbit_data)

    expect(tidbit).to respond_to(:title)
    expect(tidbit).to respond_to(:url)
  end
end
