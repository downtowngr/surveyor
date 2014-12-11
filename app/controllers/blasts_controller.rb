class BlastsController < ApplicationController
  before_filter :get_blast, except: [:index, :new, :create, :deliver]

  def index
    @blasts = Blast.all
  end

  def show
    @questions = @blast.questions
    @list = @blast.list
  end

  def new
    @blast = Blast.new
    @list = List.find(params[:list_id])
  end

  def create
    @blast = Blast.new(blast_params)

    if @blast.save
      flash[:notice] = "Successfully created #{@blast.name}"
      redirect_to blast_path(@blast)
    else
      render "new"
    end
  end

  def deliver
    @blast = Blast.find(params[:blast_id])

    SendBlastToList.perform_async(@blast.id)
    flash[:notice] = "Successfully sent #{@blast.name}"
    redirect_to blast_path(@blast)
  end

  private

  def get_blast
    @blast = Blast.find(params[:id])
  end

  def blast_params
    params.require(:blast).permit(:name, :message, :list_id)
  end
end
