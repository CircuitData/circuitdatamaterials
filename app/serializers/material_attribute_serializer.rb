class MaterialAttributeSerializer < ActiveModel::Serializer
  attributes(
    :ipc_standard,
    :cti,
    :df,
    :dielectric_breakdown,
    :dk,
    :electric_strength,
    :filler,
    :finish,
    :flame_retardant,
    :foil_roughness,
    :ipc_slash_sheet,
    :frequency,
    :ipc_sm_840_class,
    :mot,
    :reinforcement,
    :resin,
    :resin_content,
    :t260,
    :t280,
    :t300,
    :td_min,
    :tg_min,
    :thermal_conductivity,
    :thickness,
    :volume_resistivity,
    :water_absorption,
    :woven_reinforcement,
    :z_cte,
    :z_cte_after_tg,
    :z_cte_before_tg,
  )

  def cti
    object.cti&.to_f
  end

  def df
    object.df&.to_f
  end

  def dielectric_breakdown
    object.dielectric_breakdown&.to_f
  end

  def dk
    object.dk&.to_f
  end

  def electric_strength
    object.electric_strength&.to_f
  end

  def frequency
    object.frequency&.to_f
  end

  def mot
    object.mot&.to_f
  end

  def resin_content
    object.resin_content&.to_f
  end

  def t260
    object.t260&.to_f
  end

  def t280
    object.t280&.to_f
  end

  def t300
    object.t300&.to_f
  end

  def thermal_conductivity
    object.thermal_conductivity&.to_f
  end

  def thickness
    object.thickness&.to_f
  end

  def volume_resistivity
    object.volume_resistivity&.to_f
  end

  def water_absorption
    object.water_absorption&.to_f
  end

  def z_cte
    object.z_cte&.to_f
  end

  def z_cte_after_tg
    object.z_cte_after_tg&.to_f
  end

  def z_cte_before_tg
    object.z_cte_before_tg&.to_f
  end
end
