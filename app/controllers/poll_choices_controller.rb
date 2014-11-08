class PollChoicesController < ApplicationController
  before_action :get_poll
  before_action :get_poll_choice, except: [:index, :new, :create]
  
  def index
    @poll_choices = @poll.poll_choices
  end

  def new
    @poll_choice = @poll.poll_choices.new
  end

  def create
    @poll_choice = @poll.poll_choices.new(poll_choice_params)
    @poll_choice.save!
    redirect_to @poll
  end

  def edit
  end
  
  private

  def poll_choice_params
    params.require(:poll_choice).permit(:name, :description)
  end
  
  def get_poll_choice
    @poll_choice = @poll.poll_choices.find(params[:id])
  end
  
  def get_poll
    @poll = Poll.find(params[:poll_id])
  end
end
