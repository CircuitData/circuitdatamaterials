
class MaterialsController < ApplicationController
  protect_from_forgery
  include Pagy::Backend
  def index
    query = MaterialSearch.new(search_params.to_h)

    if query.has_valid_params?
      @pagy, @results = pagy(query.results)
    end
  end

  def show
    @material = Material.find(params[:id])
  end

  def update
    @material = Material.find(params[:id])
    if session[:compare].include?(params[:id])
      session[:compare].delete(params[:id])
    else
      session[:compare].append(params[:id])
    end
    if params[:redirect]
      redirect_to params[:redirect]
    else
      redirect_to @material
    end
  end

  def compare
    @materials = MaterialComparator.new(session[:compare]).compare
  end

  def datasheet
    @material = Material.find(params[:id])
    sheet = @material.datasheet
    return send_sheet(sheet) if sheet.exist?
  end

  private

  def send_sheet(sheet)
    send_data(
      sheet.contents.read,
      filename: sheet.filename,
      type: "application/pdf",
      disposition: "inline",
    )
  end

  def search_params
    params.permit(:material_name, :material_function, :manufacturer_id, :numerical_filter, :min, :max)
  end
end
