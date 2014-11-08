require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET index" do
    it "assigns all users" do
      get :index
      expect(assigns(:users)).to eq(User.all)
    end
  end
end
