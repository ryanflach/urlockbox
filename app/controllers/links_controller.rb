class LinksController < ApplicationController
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

  def update
    @link = Link.find(params[:id])
    @link.update_attributes(read: @link.opposite_read_value)
    redirect_to links_path
  end

  private

  def link_params
    params.require(:link).permit(:url, :title, :user_id)
  end
end
