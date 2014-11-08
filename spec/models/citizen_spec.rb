require 'rails_helper'

RSpec.describe Citizen, type: :model do
  let(:invalid_phone_number) { '616403' }

  describe "Citizen normalizers" do
    # Can't get rspec to see normalize helpers
#    it { should normalize_attribute(:phone_number).from("1 (616) 403-8767").to("16164038767") }
  end
  
  describe "Citizen validations" do
    it "should require a valid phone number" do
      expect { Citizen.create(phone_number: invalid_phone_number) }.not_to change { Citizen.count }
    end
  end
end
