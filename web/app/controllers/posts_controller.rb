class PostsController < ApplicationController
  def index

  end

  def new

  end

  def create
    params = request.request_parameters
    RunPal::CreatePost.run(params)
  end

end
