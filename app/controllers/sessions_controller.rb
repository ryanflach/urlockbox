class SessionsController < ApplicationController
  def new
    redirect_to links_path if current_user
  end

  def create
  end
end
