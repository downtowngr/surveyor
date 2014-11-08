FactoryGirl.define do
  factory :poll_choice do
    sequence(:name) { |n| "choice#{n}" }
    poll
  end
end
