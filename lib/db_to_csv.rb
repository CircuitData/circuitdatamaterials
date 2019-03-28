require "csv"

class DbToCsv
  COLUMNS = [
    :circuitdata_material_db_id,
    :accept_equivalent,
    :additional,
    :cti,
    :df,
    :dielectric_breakdown,
    :dk,
    :electric_strength,
    :filler,
    :finish,
    :flame_retardant,
    :flexible,
    :foil_roughness,
    :frequency,
    :function,
    :group,
    :ipc_slash_sheet,
    :ipc_sm_840_class,
    :ipc_standard,
    :link,
    :manufacturer,
    :mot,
    :name,
    :reinforcement,
    :remark,
    :resin,
    :resin_content,
    :t260,
    :t280,
    :t300,
    :td_min,
    :tg_min,
    :thermal_conductivity,
    :thickness,
    :ul94,
    :verified,
    :volume_resistivity,
    :water_absorption,
    :woven_reinforcement,
    :z_cte,
    :z_cte_after_tg,
    :z_cte_before_tg,
  ]

  def headers
    COLUMNS
  end

  def body
    @body ||= build_body
  end

  def to_csv
    column_names = body.first.keys
    CSV.generate do |csv|
      csv << column_names
      body.each do |x|
        csv << x.values
      end
    end
  end

  private

  def build_body
    Material.all.map do |material|
      { circuitdata_material_db_id: material.id,
       name: material.name,
       link: material.link,
       remark: material.remark,
       function: material.function,
       group: material.group,
       additional: material.additional,
       flexible: material.flexible,
       accept_equivalent: material.accept_equivalent,
       ul94: material.ul_94,
       verified: material.verified,
       ipc_standard: material.ipc_standard,
       cti: first_number(material, "cti"),
       filler: values(material, "filler"),
       finish: first_value(material, "finish"),
       flame_retardant: first_value(material, "flame_retardant"),
       ipc_slash_sheet: values(material, "ipc_slash_sheet"),
       ipc_sm_840_class: first_value(material, "ipc_sm_840_class"),
       manufacturer: material.manufacturer&.name,
       foil_roughness: first_value(material, "foil_roughness"),
       resin: first_value(material, "resin"),
       resin_content: first_number(material, "resin_content"),
       reinforcement: first_value(material, "reinforcement"),
       dielectric_breakdown: first_number(material, "dielectric_breakdown"),
       thermal_conductivity: first_number(material, "thermal_conductivity"),
       thickness: first_number(material, "thickness"),
       volume_resistivity: first_number(material, "volume_resistivity"),
       water_absorption: first_number(material, "water_absorption"),
       woven_reinforcement: "t" == first_value(material, "woven_reinforcement"),
       electric_strength: first_number(material, "electric_strength"),
       frequency: first_number(material, "frequency"),
       dk: first_number(material, "dk"),
       z_cte: first_number(material, "z_cte"),
       z_cte_after_tg: first_number(material, "z_cte_after_tg"),
       z_cte_before_tg: first_number(material, "z_cte_before_tg"),
       t260: first_number(material, "t260"),
       t280: first_number(material, "t280"),
       t300: first_number(material, "t300"),
       tg_min: first_number(material, "tg_min"),
       td_min: first_number(material, "td_min"),
       mot: first_number(material, "mot"),
       df: first_number(material, "df") }
    end
  end

  def first_number(material, attr)
    val = first_value(material, attr)
    val.nil? ? nil : val.to_i
  end

  def first_value(material, attr)
    material.material_attributes.find_by_name(attr)&.material_attribute_values&.first&.value
  end

  def values(material, attr)
    vals = material.material_attributes.find_by_name(attr)&.material_attribute_values&.pluck(:value) || []
    vals.join("|")
  end
end
