class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def new
    @list = List.new
  end

  def create
    List.create_from_nationbuilder_tag(params[:nationbuilder_tag])
    redirect_to lists_path
  end

  def show
    @list = List.find(params[:id])
  end

  private

  def nationbuilder_list_params
    params.permit(:nationbuilder_tag)
  end
end
