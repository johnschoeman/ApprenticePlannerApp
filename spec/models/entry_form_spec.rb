require "rails_helper"

RSpec.describe "EntryForm" do
  it "initializes with a blank entry and three blank goals" do
    entry_form = EntryForm.new

    expect(entry_form.entry).to be_a_kind_of(Entry)
    expect(entry_form.goals.length).to eq 3
    expect(entry_form.goals.first).to be_a_kind_of(Goal)
  end
end
