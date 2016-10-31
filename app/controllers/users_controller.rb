class UsersController < ApplicationController
  before_action :process_password_mismatch, only: [:create]

  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to links_path
    else
      flash.now[:danger] = user.erorrs.full_messages.join(', ')
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def process_password_mismatch
    if !passwords_match?('user')
      flash[:danger] = 'Passwords must match. Please try again.'
      redirect_to new_user_path
    end
  end
end
