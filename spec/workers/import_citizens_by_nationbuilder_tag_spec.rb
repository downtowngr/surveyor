require "rails_helper"

RSpec.describe ImportCitizensByNationbuilderTag do
  let(:list) { create(:list) }

  context "person with mobile number" do
    use_vcr_cassette :real_person

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

  context "person without mobile number" do
    use_vcr_cassette :no_phone

    it "does not create a citizen" do
      expect {
        ImportCitizensByNationbuilderTag.new.perform(list.id, "No-Phone")
      }.not_to change { list.citizens.count }
    end
  end

  context "person opted-out of mobile" do
    use_vcr_cassette :opt_out

    it "does not create a citizen" do
      expect {
        ImportCitizensByNationbuilderTag.new.perform(list.id, "Opted-Out")
      }.not_to change { list.citizens.count }
    end
  end

  context "correctly paginates over hundreds of results" do
    use_vcr_cassette :dummy_data

    it "creates hundreds of citizens" do
      expect {
        ImportCitizensByNationbuilderTag.new.perform(list.id, "Dummy-Data")
      }.to change { list.citizens.count }.from(0).to(249)
    end
  end
end
