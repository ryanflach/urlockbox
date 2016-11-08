class LinksController < ApplicationController
  before_action :set_link, only: [:edit, :update]

  def index
    redirect_to login_path and return if !current_user
    @links = Link.where(user: current_user)
  end

  def create
    @link = Link.new(parsed_link_params)
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
    if @link.update(parsed_link_params)
      flash[:success] = "Link updated successfully."
      redirect_to links_path
    else
      flash.now[:danger] = @link.errors.full_messages.join(', ')
      render :edit
    end
  end

  private

  def link_params
    params.require(:link).permit(:url, :title, :user_id, :tags)
  end

  def set_link
    @link = Link.find(params[:id])
  end

  def parsed_link_params
    clean_params = link_params
    clean_params[:tags] = stripped(clean_params[:tags])
    clean_params
  end

  def stripped(words)
    separated = words.downcase.split(',')
    separated.map { |word| Tag.find_or_create_by(name: word.strip) }
  end

end
