class ListenersController < ApplicationController
  def index
    @keyword_listeners = KeywordListener.all
    @number_listeners  = NumberListener.all
  end
end
