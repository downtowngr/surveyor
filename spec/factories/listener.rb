FactoryGirl.define do
  factory :listener do
    sequence(:keyword) { |n| "keyword#{n}" }
    poll
  end
end
