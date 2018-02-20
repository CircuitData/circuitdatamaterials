class MaterialsController < ApplicationController
  def index
  	if params[:function]
  	  @materials = Material.where(function: params[:function].downcase)
    else
      @materials = Material.all
    end
    if @materials.present?
      render json: @materials, status: :ok
    else
      raise ActiveRecord::RecordNotFound,"Material with function: " + params[:function] + ", not found"
    end
  end
  def show
    @material = Material.find(params[:id])
    render json: @material, status: :ok
  end
end
