class ManufacturersController < ApplicationController
  def index
    @manufacturers = Manufacturer.all
    paginate json: @manufacturers
  end

  def show
    @manufacturer = Manufacturer.find(params[:id])
    render json: @manufacturer#, include: 'materials'
  end
end
