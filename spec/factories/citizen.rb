FactorGirl.define do
  factory :citizen do
    phone_number { Faker::PhoneNumber.cell_phone }
  end
end
