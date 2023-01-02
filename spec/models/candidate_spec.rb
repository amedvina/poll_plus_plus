require "rails_helper"

RSpec.describe Candidate, type: :model do
    it { should belong_to(:poll) }
    it { should validate_presence_of(:title) }
    it { should have_many(:votes).dependent(:destroy) }

    describe "#candidate_votes" do
        let(:poll) { Poll.create!(title: "Poll", start_time: "2022-09-29T16:31", end_time: "2022-09-29T14:34") }
        let(:candidate_one) { Candidate.create!(title: "Candidate one", poll: poll) }

        subject { candidate_one.candidate_votes }

        context "when candidate has votes" do
            let!(:vote1) { Vote.create!(candidate: candidate_one) }
            let!(:vote2) { Vote.create!(candidate: candidate_one) }
            let!(:vote3) { Vote.create!(candidate: candidate_one) }

            it "calculates the result" do
                expect(subject).to eq(3)
            end
        end

        context "when candidate has no votes" do
            it "calculates the result" do
                expect(subject).to eq(0)
            end
        end
    end
end
