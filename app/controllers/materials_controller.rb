
class MaterialsController < ApplicationController
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

  def compare
    if params[:material_ids].nil?
      params[:material_ids] = [nil, nil]
    end
    if params[:commit] == "Add material"
      params[:material_ids].append(nil)
    end
    @materials = []
    params[:material_ids].each do |uuid|
      @materials.append(Material.find_by(id: uuid))
    end
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
