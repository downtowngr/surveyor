class BlastsController < ApplicationController
  before_filter :get_blast, except: [:index, :new, :create]

  def index
    @blasts = Blast.all
  end

  def show
    @citizens = @blast.citizens
  end

  def new
    @blast = Blast.new
    @citizens = Citizen.find(CitizenList.new(params[:ids]).array)
  end

  def create
    @blast = Blast.new(blast_params)

    if @blast.save
      @blast.citizens.each do |citizen|
        TwilioSend.perform_async(citizen.phone_number, @blast.message)
      end

      flash[:notice] = "Successfully created #{@blast.name}"
      redirect_to blast_path(@blast)
    else
      render "new"
    end
  end

  private

  def get_blast
    @blast = Blast.find(params[:id])
  end

  def blast_params
    params.require(:blast).permit(:name, :message, citizen_ids: [])
  end
end
