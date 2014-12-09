require 'rails_helper'

RSpec.describe Citizen, type: :model do
  describe "validations" do
    it "should require a valid phone number" do
      expect { Citizen.create(phone_number: "61616") }.not_to change { Citizen.count }
    end
  end

  describe "#localized_phone" do
    it "returns a 10 digit phone number" do
      citizen = build(:citizen, phone_number: "16165551234")
      expect(citizen.localized_phone).to eq("6165551234")
    end
  end

  describe "#e164_phone" do
    it "returns an e164 formatted phone number" do
      citizen = build(:citizen, phone_number: "16165551234")
      expect(citizen.e164_phone).to eq("+16165551234")
    end
  end

  describe "#sync_to_nationbuilder!" do
    context "when citizen has nationbuilder_id" do

    end

    context "when citizen does not have nationbuilder_id" do
      context "when citizen has email address", vcr: {cassette_name: :new_person_record} do
        let!(:citizen) { create(:citizen, phone_number: "16165559988", email: "high@example.com") }

        it "sets nationbuilder_id" do
          citizen.sync_to_nationbuilder!

          expect(citizen.nationbuilder_id).not_to be nil

          response = $nb.call(:people, :show, id: citizen.nationbuilder_id)
          person = response["person"]

          expect(person["email"]).to eq("high@example.com")
          expect(person["mobile_opt_in"]).to be true
          expect(person["mobile"]).to eq("6165559988")
        end
      end

      context "when citizen does not have email address", vcr: {cassette_name: :no_email} do
        let!(:citizen) { create(:citizen, phone_number: "16165559989", email: nil) }

        it "sets nationbuilder_id" do
          citizen.sync_to_nationbuilder!

          expect(citizen.nationbuilder_id).not_to be nil

          response = $nb.call(:people, :show, id: citizen.nationbuilder_id)
          person = response["person"]

          expect(person["email"]).to be nil
          expect(person["mobile_opt_in"]).to be true
          expect(person["mobile"]).to eq("6165559989")
        end
      end
    end

    context "when citizen has tags", vcr: {cassette_name: :tag_citizen} do
      let!(:citizen) { create(:citizen, phone_number: "16165559999", email: "tag_citizen@example.com") }

      it "tags the corresponding citizen" do
        citizen.nationbuilder_tags = ["This-Works!", "LikeABoss"]

        citizen.sync_to_nationbuilder!

        expect(citizen.nationbuilder_id).not_to be nil

        response = $nb.call(:people, :show, id: citizen.nationbuilder_id)
        person = response["person"]

        expect(person["email"]).to eq("tag_citizen@example.com")
        expect(person["mobile_opt_in"]).to be true
        expect(person["mobile"]).to eq("6165559999")
        expect(person["tags"]).to eq(["LikeABoss", "This-Works!"])
      end
    end
  end

  describe ".update_or_create_from_nationbuilder", vcr: {cassette_name: :full_person} do
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
