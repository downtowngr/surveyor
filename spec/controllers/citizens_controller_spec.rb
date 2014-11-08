require 'rails_helper'

RSpec.describe CitizensController, type: :controller do
  let(:valid_phone_number) { Faker::PhoneNumber.cell_phone }
  
  describe "GET index" do
    it "assigns all citizens" do
      citizen = Citizen.create!(phone_number: valid_phone_number)
      get :index
      expect(assigns(:citizens).all).to eq([citizen])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET new" do
    it "assigns a new citizen" do
      get :new
      expect(assigns(:citizen)).to be_instance_of(Citizen)
      expect(assigns(:citizen).persisted?).to be false
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST create" do
    it "creates a new citizen" do
      expect { post :create, citizen: {phone_number: valid_phone_number } }.to change { Citizen.count }.by(1)
    end

    it "redirects to the Citizen index" do
      expect(post :create, citizen: {phone_number: valid_phone_number}).to redirect_to(citizens_path)
    end
  end
end
