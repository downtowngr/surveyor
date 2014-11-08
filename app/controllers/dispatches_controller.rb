class DispatchesController < ApplicationController
  def index
    @dispatches = Dispatch.all
  end
end
