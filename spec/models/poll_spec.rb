require "rails_helper"

RSpec.describe Poll, type: :model do
	it { should validate_presence_of(:title) }
	it { should have_many(:candidates).dependent(:destroy) }
	it { should accept_nested_attributes_for(:candidates) }

	describe "#final_result with factories" do

		subject { poll.final_result }

		context "when there is a winner" do
			let(:poll) { create(:poll, :with_candidates_and_no_votes) } 

			it "calculates the winning candidate" do
				candidate2 = poll.candidates.second
				candidate2.votes << create(:vote, candidate: candidate2)

				expect(subject).to eq(candidate2)
			end
		end

		context "when there is a draw" do
			let(:poll) { create(:poll, :with_candidates_and_votes) }
			
			it "calculates the winning candidate" do
				expect(subject).to eq(poll.candidates)
			end
		end

		context "when there is no winner" do
			let(:poll) { create(:poll) }

			it "calculates the winning candidate" do
				expect(subject).to be_empty
			end
		end
	end
end
