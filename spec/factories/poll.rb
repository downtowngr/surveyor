FactoryGirl.define do
  factory :poll do
    sequence(:name) { |n| "Poll #{n}" }
  end
end
