class MigrateDataToMaterials
  def self.run(materials)
    new(materials).run
  end

  def initialize(materials)
    @materials = materials
  end

  def run
    materials.each do |material|
      migrate_material(material)
    end
    error_map
  end

  private

  attr_reader :materials

  def migrate_material(material)
    material.update!(attributes_from_other_tables(material))
  end

  def attributes_from_other_tables(material)
    {
      cti: first_number(material, "cti"),
      filler: values(material, "filler"),
      finish: first_value(material, "finish"),
      flame_retardant: first_value(material, "flame_retardant"),
      ipc_slash_sheet: values(material, "ipc_slash_sheet")&.map(&:to_i),
      ipc_sm_840_class: first_value(material, "ipc_sm_840_class"),
      foil_roughness: first_value(material, "foil_roughness"),
      resin: first_value(material, "resin"),
      resin_content: first_number(material, "resin_content"),
      reinforcement: first_value(material, "reinforcement"),
      dielectric_breakdown: first_number(material, "dielectric_breakdown"),
      thermal_conductivity: first_number(material, "thermal_conductivity"),
      thickness: first_number(material, "thickness"),
      volume_resistivity: first_number(material, "volume_resistivity"),
      water_absorption: first_number(material, "water_absorption"),
      woven_reinforcement: boolean(material, "woven_reinforcement"),
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
      df: first_number(material, "df"),
    }
  end

  def boolean(material, attr)
    val = first_value(material, attr)
    return if val.nil?
    val == "t"
  end

  def first_number(material, attr)
    val = first_value(material, attr)

    return nil if val.nil?

    number = val.to_f
    if number.to_s != val && (val.to_i.to_s != val)
      error_map[material] ||= []
      error_map[material] << attr
      return nil
    end
    number
  end

  def first_value(material, attr)
    material.material_attributes.find_by_name(attr)&.material_attribute_values&.first&.value
  end

  def values(material, attr)
    values = material.material_attributes.find_by_name(attr)&.material_attribute_values&.pluck(:value)&.compact
    if values.present? && !values.empty?
      return values
    else
      nil
    end
  end

  def error_map
    @error_map ||= {}
  end
end
