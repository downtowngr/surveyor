require "rails_helper"

RSpec.describe ImportCitizensByNationbuilderTag do
  let(:list) { create(:list) }

  context "person with mobile number", vcr: {cassette_name: :real_person} do
    it "creates a citizen with a phone number" do
      expect {
        ImportCitizensByNationbuilderTag.new.perform(list.id, "Real-Person")
      }.to change { list.citizens.count }.from(0).to(1)

      citizen = list.citizens.first

      expect(citizen.phone_number).to eq("16165554321")
      expect(citizen.full_name).to eq("Real Person")
      expect(citizen.mobile_opt_in).to be true
      expect(citizen.nationbuilder_id).not_to be nil
    end
  end

  context "person without mobile number", vcr: {cassette_name: :no_phone} do
    it "does not create a citizen" do
      expect {
        ImportCitizensByNationbuilderTag.new.perform(list.id, "No-Phone")
      }.not_to change { list.citizens.count }
    end
  end

  context "person opted-out of mobile", vcr: {cassette_name: :opt_out} do
    it "does not create a citizen" do
      expect {
        ImportCitizensByNationbuilderTag.new.perform(list.id, "Opted-Out")
      }.not_to change { list.citizens.count }
    end
  end

  context "correctly paginates over hundreds of results", vcr: {cassette_name: :dummy_data} do
    it "creates hundreds of citizens" do
      expect {
        ImportCitizensByNationbuilderTag.new.perform(list.id, "Dummy-Data")
      }.to change { list.citizens.count }.from(0).to(249)
    end
  end
end
