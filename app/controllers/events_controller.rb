class EventsController < ApplicationController
  before_filter :get_event, except: [:index, :new, :create]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      flash[:notice] = "Successfully created #{@event.name}"
      redirect_to event_path(@event)
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      flash[:notice] = "Successfully updated #{@event.name}"
      redirect_to event_path(@event)
    else
      render "edit"
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  private

  def get_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :keyword, :description, :autoresponse, :start_date, :end_date)
  end
end
