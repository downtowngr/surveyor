require 'rails_helper'

RSpec.describe DispatchController, type: :controller do
  describe "trigger" do
    let(:from_phone) { "+16164993901" }

    it "should process a text with a known keyword" do
      poll_choice = create(:poll_choice)

      dispatch_class_mock = class_double("Dispatch").as_stubbed_const(:transfer_nested_constants => true)
      dispatch_mock = instance_double("Dispatch")
      expect(dispatch_mock).to receive(:trigger)
      expect(dispatch_class_mock).to receive(:find_by).with({keyword: poll_choice.name}).and_return(dispatch_mock)

      get :trigger, {"Body" => "#{poll_choice.name}", "From" => from_phone}
    end
  end
end
