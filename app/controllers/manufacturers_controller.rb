class ManufacturersController < ApplicationController
  def index
    @manufacturer_count = Manufacturer.count
    @manufacturers = Manufacturer.all.group_by { |m| m.name.upcase.first }
  end

  def show
    @manufacturer = Manufacturer.find(params[:id])
    render json: @manufacturer #, include: 'materials'
  end
end
