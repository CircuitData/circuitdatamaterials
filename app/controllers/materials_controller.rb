class MaterialsController < ApplicationController
  def index
    if has_search_params?
      @results = search_scope.limit(50)
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

  def has_search_params?
    params.has_key?(:material_name)
  end

  def search_scope
    Material.where("name ilike :name", name: "%#{params[:material_name]}%")
  end
end
