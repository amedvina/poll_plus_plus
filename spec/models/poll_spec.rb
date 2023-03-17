require "rails_helper"

RSpec.describe Poll, type: :model do
	it { should validate_presence_of(:title) }
	it { should validate_presence_of(:author_id) }
	it { should belong_to(:author).class_name('User') }
	it { should have_many(:candidates).dependent(:destroy) }
	it { should accept_nested_attributes_for(:candidates) }
end
