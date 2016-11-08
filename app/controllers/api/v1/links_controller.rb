class Api::V1::LinksController < ApplicationController
  def update
    @link = Link.find(params[:id])
    @link.update_attributes(read: @link.opposite_read_value)
    render json: @link
  end
end
