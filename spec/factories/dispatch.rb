FactoryGirl.define do
  factory :dispatch do
    sequence(:keyword) { |n| "keyword#{n}" }
    poll
  end
end
