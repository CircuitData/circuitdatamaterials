
class MaterialsController < ApplicationController
  include Pagy::Backend

  MATERIAL_ATTRIBUTES = {
    "default" => ["id", "function", "group", "link", "ipc_standard"],
    "conductive" => ["foil_roughness", "flexible", "thermal_conductivity"],
    "dielectric" => ["flexible", "ul_94", "cti", "df", "dielectric_breakdown",
      "dk", "electric_strength", "mot", "t260", "t280", "t300", "td_min",
      "tg_min", "thermal_conductivity", "water_absorption", "z_cte",
      "z_cte_after_tg", "z_cte_before_tg", "ipc_slash_sheet", "finish"],
    "soldermask" => ["flexible", "thermal_conductivity", "ipc_sm_840_class"],
    "stiffener" => [],
    "final_finish" => []
  }

  def index
    query = MaterialSearch.new(search_params.to_h)

    if query.has_valid_params?
      @pagy, @results = pagy(query.results)
    end
  end

  def show
    @material = Material.find(params[:id])
    @attributes = @material.attributes.slice(
      *MATERIAL_ATTRIBUTES["default"]+MATERIAL_ATTRIBUTES[@material.attributes["function"]])
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
