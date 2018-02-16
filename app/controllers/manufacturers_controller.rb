class ManufacturersController < ApplicationController
  def index
  	if params[:tull] == "23"
  		@message= "666"
  		render json: @message.to_enum.to_json
    else
    @manufacturers = Manufacturer.all
    render json: @manufacturers
end
  end
  def show
    @manufacturer = Manufacturer.find(params[:id])
    render json: @manufacturer#, include: 'materials'
  end
end
