require "rails_helper"

RSpec.describe Polls::Result, type: :model do
	let(:result) { Polls::Result.new(poll) }

	describe "#winning_candidates" do
		subject { result.winning_candidates }
		
		context "when there is a winner" do
			let(:poll) { create(:poll, :with_candidates_and_no_votes) } 
			
			it "calculates the winning candidate" do
				candidate2 = poll.candidates.second
				candidate2.votes << create(:vote, candidate: candidate2)

				expect(subject).to contain_exactly(candidate2)
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