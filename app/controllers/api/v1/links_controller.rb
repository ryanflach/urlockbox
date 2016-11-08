class Api::V1::LinksController < ApplicationController
  before_action :set_link

  def update
    @link.update_attributes(read: @link.opposite_read_value)
    render json: @link
  end

  def destroy
    @link.destroy
    render json: @link
  end

  private

  def set_link
    @link = Link.find(params[:id])
  end
end
