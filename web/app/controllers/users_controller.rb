class UsersController < ApplicationController
  def new

  end

  def create
    params = request.request_parameters
    RunPal::CreateUser.run(params)
  end
end
