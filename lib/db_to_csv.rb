require "csv"

class DbToCsv
  SIMPLE_ATTRS = [
    :circuitdata_material_db_id,
    :accept_equivalent,
    :additional,
    :cti,
    :df,
    :dielectric_breakdown,
    :dk,
    :electric_strength,
    :finish,
    :flame_retardant,
    :flexible,
    :foil_roughness,
    :frequency,
    :function,
    :group,
    :ipc_sm_840_class,
    :ipc_standard,
    :link,
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
    :verified,
    :volume_resistivity,
    :water_absorption,
    :woven_reinforcement,
    :z_cte,
    :z_cte_after_tg,
    :z_cte_before_tg,
  ]

  COLUMNS = SIMPLE_ATTRS + [
    :manufacturer,
    :filler,
    :ipc_slash_sheet,
    :ul94,
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
    attr_names = SIMPLE_ATTRS.map(&:to_s)
    Material.all.map do |material|
      {
        circuitdata_material_db_id: material.id,
        manufacturer: material.manufacturer&.name,
        filler: values(material, "filler"),
        ul94: material.ul_94,
        ipc_slash_sheet: values(material, "ipc_slash_sheet"),
      }.merge(material.attributes.slice(*attr_names)).transform_values(&:to_s)
    end
  end

  def values(material, attr)
    material[attr]&.join("|")
  end
end
