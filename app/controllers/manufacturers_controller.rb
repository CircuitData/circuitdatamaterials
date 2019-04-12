class ManufacturersController < ApplicationController
  def index
    @manufacturers = Manufacturer.all.group_by { |m| m.name.downcase.first }
  end

  def show
    @manufacturer = Manufacturer.find(params[:id])
    render json: @manufacturer #, include: 'materials'
  end
end
