require "rails_helper"

RSpec.describe Poll, type: :model do
    it { should validate_presence_of(:title) }
    it { should have_many(:candidates)}
end