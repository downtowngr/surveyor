FactoryGirl.define do
  factory :citizen do
    phone_number { Faker::PhoneNumber.cell_phone }
  end

  factory :listener do
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
end
