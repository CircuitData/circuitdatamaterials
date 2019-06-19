
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
    num_materials = params[:num_to_compare].to_i || 0
    if params[:commit] == "Add material"
      num_materials += 1
    end

    @materials = []
    (0..num_materials-1).each do |i|
      uuid =  params["material_#{i}_uuid"]
      @materials.append(Material.exists?(uuid) ? Material.find(uuid) : nil)
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
