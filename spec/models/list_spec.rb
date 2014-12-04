require "rails_helper"

RSpec.describe List, type: :model do
  let(:citizens) { create_list(2, :citizen) }

  it "holds a list of citizens" do
    list = List.create(citizens: citizens)
    expect(list.citizens.count).to eq(2)
  end

  it "sets its name to type, count, and date"

  describe ".create_from_nationbuilder_tag" do
  end
end
