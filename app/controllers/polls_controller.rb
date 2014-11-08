class PollsController < ApplicationController
  before_filter :get_poll, except: [:index, :new, :create]

  def index
    @polls = Poll.all
  end

  def show
  end

  def new
    @poll = Poll.new
  end

  def create
    @poll = Poll.new(poll_params)

    if @poll.save
      flash[:notice] = "Successfully created #{@poll.name}"
      redirect_to poll_path(@poll)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @poll.update(poll_params)
      flash[:notice] = "Successfully updated #{@poll.name}"
      redirect_to poll_path(@poll)
    else
      render 'edit'
    end
  end

  def destroy
    @poll.destroy
    redirect_to polls_path
  end

  private

  def get_poll
    @poll = Poll.find(params[:id])
  end

  def poll_params
    params.require(:poll).permit(:name, :description, :start_date, :end_date, :strategy)
  end
end
