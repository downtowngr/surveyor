require 'rails_helper'

RSpec.describe Citizen, type: :model do
  use_vcr_cassette :full_person

  describe "validations" do
    it "should require a valid phone number" do
      expect { Citizen.create(phone_number: "61616") }.not_to change { Citizen.count }
    end
  end

  describe ".update_or_create_from_nationbuilder" do
    context "when a user does not exist for a given number" do
      it "creates a citizen" do
        response = $nb.call(:people, :show, id: 10)

        expect {
          Citizen.update_or_create_from_nationbuilder(response["person"])
        }.to change {
          Citizen.count
        }.from(0).to(1)

        citizen = Citizen.first

        expect(citizen.phone_number).to eq("16165557788")
        expect(citizen.nationbuilder_id).to eq(10)
        expect(citizen.email).to eq("full_person@example.com")
        expect(citizen.full_name).to eq("Full Person")
        expect(citizen.mobile_opt_in).to be true
      end
    end

    context "when a user already exists for a given number" do
      let!(:citizen) { create(:citizen, phone_number: "16165557788", full_name: "Old Name", email: "old_email@example.com", mobile_opt_in: false) }

      it "updates the citizen" do
        response = $nb.call(:people, :show, id: 10)

        expect {
          Citizen.update_or_create_from_nationbuilder(response["person"])
        }.not_to change {
          Citizen.count
        }

        citizen.reload

        expect(citizen.phone_number).to eq("16165557788")
        expect(citizen.nationbuilder_id).to eq(10)
        expect(citizen.email).to eq("full_person@example.com")
        expect(citizen.full_name).to eq("Full Person")
        expect(citizen.mobile_opt_in).to be true
      end
    end

    context "when a user already exists with a given nationbuilder id" do
      let!(:citizen) { create(:citizen, nationbuilder_id: 10, phone_number: "16165551234", full_name: "Old Name", email: "old_email@example.com", mobile_opt_in: false) }

      it "updates the citizen" do
        response = $nb.call(:people, :show, id: 10)

        expect {
          Citizen.update_or_create_from_nationbuilder(response["person"])
        }.not_to change {
          Citizen.count
        }

        citizen.reload

        # Changes phone number only when found by id
        expect(citizen.phone_number).to eq("16165557788")
        expect(citizen.nationbuilder_id).to eq(10)
        expect(citizen.email).to eq("full_person@example.com")
        expect(citizen.full_name).to eq("Full Person")
        expect(citizen.mobile_opt_in).to be true
      end
    end
  end
end
