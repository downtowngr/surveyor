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
    @citizens = List.find(params[:list_id]).citizens
  end

  def create
    @blast = Blast.new(blast_params)

    if @blast.save
      SendBlastToList.perform_async(@blast.id)
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
    params.require(:blast).permit(:name, :message, :list_id)
  end
end
