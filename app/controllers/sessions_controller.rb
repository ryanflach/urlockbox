class SessionsController < ApplicationController
  def new
    redirect_to links_path if current_user
  end

  def create
    create_account if new_user?
  end

  private

  def new_user?
    params[:commit] == "Sign Up"
  end

  def create_account
    
  end
end
