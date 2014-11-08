require 'rails_helper'

RSpec.describe DispatchController, type: :controller do
  describe "trigger" do
    let(:from_phone) { "+16164993901" }
    
    it "should process a text with a known keyword" do
      poll_choice = create(:poll_choice)
      dispatch_mock = class_double("Dispatch")
      expect(dispatch_mock).to receive(:find_by).with({keyword: poll_choice.name})
      get :trigger, {"Body" => "#{poll_choice.name}", "From" => from_phone}
    end
  end
end
