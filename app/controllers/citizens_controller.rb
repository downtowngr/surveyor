class CitizensController < ApplicationController

  def index
    @citizens = Citizen.all
  end

  def new
    @citizen = Citizen.new
  end

  def create
    @citizen = Citizen.new(citizen_params)
    @citizen.save
    redirect_to citizens_path
  end


  private

  def citizen_params
    params.require(:citizen).permit!
  end

end
