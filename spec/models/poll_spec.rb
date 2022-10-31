require "rails_helper"

RSpec.describe Poll, type: :model do
    it { should validate_presence_of(:title) }
    it { should have_many(:candidates).dependent(:destroy) }
    it { should accept_nested_attributes_for(:candidates) }

    describe "#winning_candidates" do
        let(:poll) { Poll.create!(title: "Poll", start_time: "2022-09-29T16:31", end_time: "2022-09-29T14:34") }
        let(:candidate_one) { Candidate.create!(title: "Candidate one", poll: poll) }
        let(:candidate_two) { Candidate.create!(title: "Candidate two", poll: poll) }
        let(:candidate_three) { Candidate.create!(title: "Candidate three", poll: poll) }

        subject { poll.winning_candidates }

        context "when there is a winner" do
            let!(:vote1) { Vote.create!(candidate: candidate_one) }
            let!(:vote2) { Vote.create!(candidate: candidate_one) }
            let!(:vote3) { Vote.create!(candidate: candidate_one) }
            let!(:vote4) { Vote.create!(candidate: candidate_two) }

            it "calculates the winning candidate" do
                expect(subject).to include(candidate_one)
                expect(subject).to_not include(candidate_two)
            end
        end

        context "when there is a draw" do
            let!(:vote1) { Vote.create!(candidate: candidate_one) }
            let!(:vote2) { Vote.create!(candidate: candidate_one) }
            let!(:vote3) { Vote.create!(candidate: candidate_two) }
            let!(:vote4) { Vote.create!(candidate: candidate_two) }

            it "calculates the winning candidate" do
                expect(subject).to include(candidate_one, candidate_two)
            end
        end

        context "when there is no winner" do
            it "calculates the winning candidate" do
                expect(subject).to be_empty
            end
        end
    end 
end
