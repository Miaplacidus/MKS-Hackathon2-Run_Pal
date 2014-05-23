class CirclesController < ApplicationController
  def index
  end

  def new
  end

  def create
    params = request.request_parameters
    RunPal::CreateCircle.run(params)
  end

end
