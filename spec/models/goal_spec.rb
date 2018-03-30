require 'rails_helper'

RSpec.describe Goal, type: :model do
  it { should belong_to(:entry) }
  it { should validate_length_of(:description).is_at_most(255) }
end
