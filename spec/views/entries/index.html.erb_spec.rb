require "rails_helper"

RSpec.describe "entries/index.html.erb" do
  it "correctly renders a tidbit link" do
    title = Faker::Lorem.sentence
    url = Faker::Internet.url
    tidbit_data = { "link" => url, "title" => title }
    tidbit = Tidbit.new(tidbit_data)
    render_entries_index(tidbit)

    expect(rendered).to have_tidbit(tidbit)
  end

  def render_entries_index(tidbit)
    assign(:tidbit, tidbit)
    assign(:entries, [])

    render
  end

  def have_tidbit(tidbit)
    have_selector(:link_or_button, tidbit.title)
  end
end
