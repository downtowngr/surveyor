FactoryGirl.define do
  factory :citizen do
    sequence(:phone_number) { |n| "616555123#{n}" }
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
    citizens { [FactoryGirl.create(:citizen)] }
  end

  factory :list do
    sequence(:name) { |n| "List #{n}" }
    collected_from "Test"
  end
end
