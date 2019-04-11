class MaterialsController < ApplicationController
  def index
    query = MaterialSearch.new(search_params.to_h)
    if query.has_valid_params?
      @results = query.results.limit(50)
    end
  end

  def show
    @material = Material.find(params[:id])
    @attributes = @material.attributes.except(
      "name", "manufacturer_id", "created_at", "updated_at"
    )
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
    params.permit(:material_name, :manufacturer_id, :numerical_filter, :min, :max)
  end
end
