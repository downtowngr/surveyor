FactoryGirl.define do
  factory :citizen do
    phone_number { "1#{Faker::Number.number(10)}" }
  end

  factory :keyword_listener do
    sequence(:keyword) { |n| "keyword#{n}" }
  end

  factory :poll_choice do
    sequence(:name) { |n| "choice#{n}" }
    poll
  end

  factory :poll do
    sequence(:name) { |n| "Poll #{n}" }
    strategy "SingleVoteStrategy"
  end

  factory :vote do
    citizen
    poll_choice
  end

  factory :event do
    sequence(:name) { |n| "CheckIn #{n}" }
    sequence(:keyword) { |n| "keyword#{n}" }
  end

  factory :check_in do
    event
    citizen
  end

  factory :blast do
    sequence(:name) { |n| "Blast #{n}" }
    message "I Hear Words!"
  end

  factory :list do
    sequence(:name) { |n| "List #{n}" }
    collected_from "Test"
  end
end
