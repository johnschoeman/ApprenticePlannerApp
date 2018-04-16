require "rails_helper"

RSpec.describe Entry, type: :model do
  describe "Validations" do
    subject { create(:entry) }
    it do
      should validate_uniqueness_of(:date).
        scoped_to(:user_id).
        with_message("already has an entry")
    end
    it { should validate_presence_of(:user).with_message("must exist") }
    it { should validate_presence_of(:date) }
    it { should have_many(:goals) }
    it { should have_one(:note) }
  end
end
