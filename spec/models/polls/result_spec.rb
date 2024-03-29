require "rails_helper"

RSpec.describe Polls::Result, type: :model do
	let(:user) { create(:user) }
	let(:result) { Polls::Result.new(poll) }

	describe "#final_result" do
		subject { result.final_result }
		
		context "when there is a winner" do
			let(:poll) { create(:poll, :with_candidates_and_no_votes, author_id: user.id) } 
			
			it "calculates the winning candidate" do
				candidate2 = poll.candidates.second
				candidate2.votes << create(:vote, candidate: candidate2)

				expect(subject).to contain_exactly(candidate2)
			end
		end

		context "when there is a draw" do
			let(:poll) { create(:poll, :with_candidates_and_votes, author_id: user.id) }
			
			it "calculates the winning candidate" do
				expect(subject).to eq(poll.candidates)
			end
		end

		context "when there is no winner" do
			let(:poll) { create(:poll, author_id: user.id) }

			it "calculates the winning candidate" do
				expect(subject).to be_empty
			end
		end
	end
end
