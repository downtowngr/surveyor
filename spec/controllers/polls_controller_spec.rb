require 'rails_helper'

RSpec.describe PollsController, type: :controller do
  let(:valid_poll_name) { "Valid Poll Name" }
  
  describe "GET index" do
    it "assigns all polls" do
      poll = Poll.create(name: valid_poll_name)
      get :index
      expect(assigns(:polls).all).to eq([poll])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET show" do
    let(:poll) { Poll.create(name: valid_poll_name) }
    
    it "assigns the poll" do
      get :show, id: poll.id
      expect(assigns(:poll)).to eq(poll)
    end

    it "renders the show template" do
      expect(get :show, id: poll).to render_template("show")
    end
  end

  describe "GET new" do
    it "assigns a new poll" do
      get :new
      expect(assigns(:poll)).to be_instance_of(Poll)
      expect(assigns(:poll).persisted?).to be false
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST create" do
    it "create a new poll" do
      expect { post :create, poll: {name: valid_poll_name} }.to change { Poll.count }.by(1)
    end

    it "redirects to the new poll" do
      expect(post :create, poll: {name: valid_poll_name}).to redirect_to(assigns(:poll))
    end
  end

  describe "GET edit" do
  end

  describe "PATCH update" do
  end

  describe "DELETE destroy" do
  end
end
