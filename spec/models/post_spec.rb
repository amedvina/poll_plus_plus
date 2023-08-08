require 'rails_helper'

RSpec.describe Post, type: :model do
  context "associations" do
    it { should belong_to(:author).class_name("User") }
  end

  context "attribute validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end
end
