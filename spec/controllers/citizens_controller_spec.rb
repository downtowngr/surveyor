require "rails_helper"

RSpec.describe CitizensController, type: :controller do
  describe "GET index" do
    it "assigns all citizens" do
      citizen = Citizen.create!(phone_number: "16162345555")
      get :index
      expect(assigns(:citizens).all).to eq([citizen])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
end
