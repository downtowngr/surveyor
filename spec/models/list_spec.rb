require "rails_helper"

RSpec.describe List, type: :model do
  let(:citizens) { create_list(:citizen, 2) }

  it "holds a list of citizens" do
    list = create(:list, citizens: citizens)
    expect(list.citizens.count).to eq(2)
  end

  it "sets its name to type, count, and date" do
    Timecop.freeze(2008, 9, 1, 10, 5, 0) do
      list = create(:list, citizens: citizens, collected_from: "nationbuilder")
      expect(list.name).to eq("Nationbuilder - 01 Sep 10:05")
    end
  end

  describe ".create_from_nationbuilder_tag" do
  end
end
