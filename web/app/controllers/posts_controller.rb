class PostsController < ApplicationController
  def index

  end

  def new
    params = request.request_parameters
    RunPal::CreatePost(params)
  end

end
