class PostsController < ApplicationController
  def index

  end

  def new

  end

  def create
    params = request.request_parameters
    RunPal::CreatePost.create_new_post(params)
  end

end
