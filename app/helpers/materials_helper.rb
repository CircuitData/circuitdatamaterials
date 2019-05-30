
module MaterialsHelper
  DEFAULT_ATTRIBUTES = ["id", "function", "group", "link", "ipc_standard"]
  MATERIAL_ATTRIBUTES = {
    "conductive" => ["foil_roughness", "flexible", "thermal_conductivity"],
    "dielectric" => ["flexible", "ul_94", "cti", "df", "dielectric_breakdown",
      "dk", "electric_strength", "mot", "t260", "t280", "t300", "td_min",
      "tg_min", "thermal_conductivity", "water_absorption", "z_cte",
      "z_cte_after_tg", "z_cte_before_tg", "ipc_slash_sheet", "finish"],
    "soldermask" => ["flexible", "thermal_conductivity", "ipc_sm_840_class"],
    "stiffener" => [],
    "final_finish" => []
  }

  def attributes_by_material_function(material)
    material.attributes.slice(
      *DEFAULT_ATTRIBUTES+MATERIAL_ATTRIBUTES.fetch(material.function))
  end
end
