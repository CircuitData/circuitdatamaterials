
module MaterialsHelper
  DEFAULT_ATTRIBUTES = ["id", "function", "group", "link", "ipc_standard"]
  MATERIAL_ATTRIBUTES = {
    "conductive" => ["foil_roughness", "flexible", "thermal_conductivity"],
    "dielectric" => ["flexible", "ul_94", "cti", "df", "dielectric_breakdown",
      "dk", "mot", "t260", "t280", "t300", "td_min",
      "tg_min", "thermal_conductivity", "water_absorption", "z_cte",
      "z_cte_after_tg", "z_cte_before_tg", "ipc_slash_sheet"],
    "soldermask" => ["flexible", "thermal_conductivity", "ipc_sm_840_class", "df", "dk", "electric_strength", "ul_94", "cti", "finish"],
    "stiffener" => [],
    "final_finish" => []
  }

  def attributes_by_function(function)
    DEFAULT_ATTRIBUTES+MATERIAL_ATTRIBUTES.fetch(function)
  end

  def attributes_by_material_function(material)
    material.attributes.slice(*attributes_by_function(material.function))
  end

  def material_values(materials)
    attrs = attributes_by_function(materials[0].function)
    attrs.map{ |attr| [attr,
      materials.map{ |material|
        material.attributes.fetch(attr)
      }]
    }.to_h
  end

  def styled_value(value, values)
    values_equal = values.uniq.size <= 1
    style="color: " + (values_equal ? "green" : "red")
    content_tag(:span, value, {style: style})
  end

  def show_attribute(attr)
    data = attr.humanize
    if Material::UNITS[attr.to_sym]
      data += "(#{Material::UNITS[attr.to_sym]})"
    end
    content_tag(:span, data)
  end

  def update_compare_button(action, material_id)
    button_text = materials_to_compare.include?(material_id) ? "Remove from Compare" : "Add To Compare"
    return button_to(button_text, {:action => action, :id => material_id },
      method: "put", class: "btn btn-primary", params: {"search" => params.to_json})
  end
end
