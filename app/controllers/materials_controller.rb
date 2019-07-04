
class MaterialsController < ApplicationController
  protect_from_forgery
  include Pagy::Backend
  def index
    query = MaterialSearch.new(search_params.to_h)

    if query.has_valid_params?
      @pagy, @results = pagy(query.results)
    end
  end

  def update_compare
    add_remove_compare
    redirect_to action: "index", params: JSON.parse(params[:search])
  end

  def show
    @material = Material.find(params[:id])
  end

  def update
    @material = Material.find(params[:id])
    add_remove_compare
    redirect_to @material
  end

  def compare
    @materials = MaterialComparator.new(session[:compare]).compare
  end

  def remove_from_compare
    session[:compare].delete(params[:id])
    redirect_to :action => 'compare'
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

  def add_remove_compare
    if session[:compare].include?(params[:id])
      session[:compare].delete(params[:id])
    else
      session[:compare].append(params[:id])
    end
  end
end
