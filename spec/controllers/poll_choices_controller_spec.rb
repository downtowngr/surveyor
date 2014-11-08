require 'rails_helper'

RSpec.describe PollChoicesController, type: :controller do
  let(:poll) { create(:poll) }
  
  describe "GET index" do
    it "assigns all choices for this post" do
      poll_choice = poll.poll_choices.create
      get :index, poll_id: poll.id
      expect(assigns(:poll)).to eq(poll)
      expect(assigns(:poll_choices).all).to eq([poll_choice])
    end

    it "renders the index template" do
      get :index, poll_id: poll.id
      expect(response).to render_template("index")
    end
  end

  describe "GET new" do
    it "assigns a new choice request for the poll" do
      get :new, poll_id: poll.id
      expect(assigns(:poll_choice)).to be_instance_of(PollChoice)
      expect(assigns(:poll_choice).persisted?).to be false
      expect(assigns(:poll_choice).poll).to eq(poll)
    end

    it "renders the new template" do
      get :new, poll_id: poll.id
      expect(response).to render_template("new")
    end
  end

  describe "POST create" do
    it "creates a new poll choice under the active poll" do
      expect { post :create, poll_id: poll.id, poll_choice: attributes_for(:poll_choice) }.to change { poll.poll_choices.count }.by(1)
    end

    it "redirects to the Poll show page" do
      expect { post :create, poll_id: poll.id, poll_choice: attributes_for(:poll_choice) }.to redirect_to(post_path(post))
    end
  end
end
