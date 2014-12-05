require "rails_helper"

RSpec.describe PhoneNumber, type: :model do
  describe "initialized with localized number" do
    it "returns returns correct" do
      phone_number = PhoneNumber.new("6165551234")

      expect(phone_number.localized).to eq("6165551234")
      expect(phone_number.national).to eq("16165551234")
      expect(phone_number.e164).to eq("+16165551234")
    end
  end

  describe "initialized with dashed number" do
    it "returns returns correct" do
      phone_number = PhoneNumber.new("616-555-1234")

      expect(phone_number.localized).to eq("6165551234")
      expect(phone_number.national).to eq("16165551234")
      expect(phone_number.e164).to eq("+16165551234")
    end
  end

  describe "initialized with paranethesized number" do
    it "returns returns correct" do
      phone_number = PhoneNumber.new("(616) 555-1234")

      expect(phone_number.localized).to eq("6165551234")
      expect(phone_number.national).to eq("16165551234")
      expect(phone_number.e164).to eq("+16165551234")
    end
  end

  describe "initialized with national number" do
    it "returns returns correct" do
      phone_number = PhoneNumber.new("16165551234")

      expect(phone_number.localized).to eq("6165551234")
      expect(phone_number.national).to eq("16165551234")
      expect(phone_number.e164).to eq("+16165551234")
    end
  end

  describe "initialize with e164 number" do
    it "returns returns correct" do
      phone_number = PhoneNumber.new("+16165551234")

      expect(phone_number.localized).to eq("6165551234")
      expect(phone_number.national).to eq("16165551234")
      expect(phone_number.e164).to eq("+16165551234")
    end
  end
end
