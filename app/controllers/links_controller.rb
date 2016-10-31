class LinksController < ApplicationController
  before_action :set_link, only: [:edit, :update]
  def index
    redirect_to login_path and return if !current_user
    @links = Link.where(user: current_user)
  end

  def create
    @link = Link.new(link_params)
    if @link.save
      flash[:success] = "Link to #{@link.title} successfully added."
      redirect_to links_path
    else
      flash[:danger] = @link.errors.full_messages.join(', ')
      redirect_to root_path
    end
  end

  def edit
  end

  def update
    if params[:link] && @link.update(link_params)
      flash[:success] = "Link updated successfully."
      redirect_to links_path
    elsif params[:link]
      flash.now[:danger] = @link.errors.full_messages.join(', ')
      render :edit
    else
      @link.update_attributes(read: @link.opposite_read_value)
      redirect_to links_path
    end
  end

  private

  def link_params
    params.require(:link).permit(:url, :title, :user_id)
  end

  def set_link
    @link = Link.find(params[:id])
  end
end
