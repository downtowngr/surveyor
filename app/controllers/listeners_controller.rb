class ListenersController < ApplicationController
  def index
    @listeners = Listener.all
  end
end
