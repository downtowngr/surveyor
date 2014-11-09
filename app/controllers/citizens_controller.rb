class CitizensController < ApplicationController
  def index
    @citizens = Citizen.all
  end

  def show
    @citizen = Citizen.find(params[:id])
  end
end
