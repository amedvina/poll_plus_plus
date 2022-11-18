FactoryBot.define do
	factory :poll do
		title { 'Poll' }
		start_time  { '2022-09-29T16:31' }
		end_time { "2022-09-29T14:34" }
	end

	trait :with_candidates_and_no_votes do
		after(:create) do |poll|
			poll.candidates = create_list :candidate, 4, poll: poll
		end
	end

	trait :with_candidates_and_votes do
		after(:create) do |poll|
			poll.candidates = create_list :candidate, 4, :with_votes, poll: poll
		end
	end

	trait :with_winning_candidate do
		after(:create) do |poll|
			poll.candidates = create_list :candidate, 1, :with_winning_votes, poll: poll
		end
	end
end 