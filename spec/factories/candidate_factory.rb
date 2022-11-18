FactoryBot.define do
	factory :candidate do
		association :poll
		title { 'Candidate' }
	end

	trait :with_votes do
		after(:create) do |candidate|
			candidate.votes = create_list :vote, 4, candidate: candidate
		end
	end

	trait :with_winning_votes do
		after(:create) do |candidate|
			candidate.votes = create_list :vote, 5, candidate: candidate
		end
	end
end 