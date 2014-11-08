FactoryGirl.define do
  factory :poll_choice do
    sequence(:name) { |n| "Poll Chocie #{n}" }
  end
end
