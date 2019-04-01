require "csv"

class CsvToDb
  STRINGS = [
    :function,
    :group,
    :additional,
    :finish,
    :flame_retardant,
    :foil_roughness,
    :ipc_sm_840_class,
    :link,
    :name,
    :reinforcement,
    :remark,
    :resin,
    :woven_reinforcement,
  ]
  FLOATS = [
    :frequency,
    :volume_resistivity,
    :water_absorption,
    :t260,
    :t280,
    :t300,
    :thermal_conductivity,
    :thickness,
    :z_cte,
    :z_cte_after_tg,
    :z_cte_before_tg,
    :cti,
    :df,
    :dielectric_breakdown,
    :dk,
    :electric_strength,
    :resin_content,
    :mot,
  ]
  INTEGERS = [
    :ipc_standard,
    :td_min,
    :tg_min,
  ]
  BOOLEANS = [
    :flexible,
    :verified,
    :woven_reinforcement,
    :accept_equivalent,
  ]
  BOOL_MAP = {
    "true" => true,
    "false" => false,
  }

  def initialize(csv_string)
    @csv = CSV.parse(csv_string, headers: true)
  end

  def materials
    @materials ||= convert_rows
  end

  def load_into_db
    materials.each do |attrs|
      Material.upsert!(attrs)
    end
  end

  private

  attr_reader :csv

  def headers
    csv.headers
  end

  def convert_rows
    strings = STRINGS.map(&:to_s)
    booleans = BOOLEANS.map(&:to_s)
    floats = FLOATS.map(&:to_s)
    integers = INTEGERS.map(&:to_s)
    csv.map do |r|
      hash = r.to_h

      {
        id: hash["circuitdata_material_db_id"],
        ul_94: hash["ul94"],
        filler: convert_array(hash["filler"]),
        ipc_slash_sheet: convert_array(hash["ipc_slash_sheet"]).map(&:to_i),
        manufacturer: Manufacturer.find_by_name(hash["manufacturer"]),
      }
        .merge(hash.slice(*strings))
        .merge(convert_booleans(hash.slice(*booleans)))
        .merge(convert_floats(hash.slice(*floats)))
        .merge(convert_integers(hash.slice(*integers)))
    end
  end

  def convert_booleans(attrs)
    attrs.transform_values { |v| BOOL_MAP[v] }
  end

  def convert_floats(attrs)
    attrs.transform_values { |v| v.to_f }
  end

  def convert_integers(attrs)
    attrs.transform_values { |v| v.to_i }
  end

  def convert_array(value)
    value.split("|")
  end
end
