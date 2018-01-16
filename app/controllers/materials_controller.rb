class MaterialsController < ApplicationController
  def index
    @materials = Material.all
    render json: @materials, status: :ok
  end
  def show
    @material = Material.find(params[:id])
    render json: @material, status: :ok
  end
end
