require "csv"

class MaterialCsvToDb
  class ManufacturerNotFound < StandardError; end
  class InvalidRowError < StandardError; end

  STRINGS = [
    :function,
    :group,
    :finish,
    :foil_roughness,
    :ipc_sm_840_class,
    :link,
    :name,
  ]
  FLOATS = [
    :water_absorption,
    :t260,
    :t280,
    :t300,
    :thermal_conductivity,
    :z_cte,
    :z_cte_after_tg,
    :z_cte_before_tg,
    :cti,
    :df,
    :dielectric_breakdown,
    :dk,
    :electric_strength,
    :mot,
  ]
  INTEGERS = [
    :ipc_standard,
    :td_min,
    :tg_min,
  ]
  BOOLEANS = [
    :flexible,
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
    Material.delete_all

    materials.each do |attrs|
      begin
        Material.upsert!(attrs)
      rescue => e
        raise InvalidRowError, "Material #{attrs[:id]} is invalid: #{e.message}"
      end
    end
  end

  private

  attr_reader :csv

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
        ipc_slash_sheet: convert_array(hash["ipc_slash_sheet"]).map(&:to_i),
        manufacturer: find_manufacturer(hash["manufacturer"]),
      }
        .merge(hash.slice(*strings))
        .merge(convert_booleans(hash.slice(*booleans)))
        .merge(convert_floats(hash.slice(*floats)))
        .merge(convert_integers(hash.slice(*integers)))
    end
  end

  def find_manufacturer(name)
    return nil if name.blank?
    m = Manufacturer.find_by_name(name)
    if m.nil?
      raise ManufacturerNotFound, "Unable to find #{name}"
    end
    m
  end

  def convert_booleans(attrs)
    attrs.transform_values { |v| BOOL_MAP[v] }
  end

  def convert_floats(attrs)
    attrs.transform_values { |v| v.blank? ? nil : v.to_f }
  end

  def convert_integers(attrs)
    attrs.transform_values { |v| v.blank? ? nil : v.to_i }
  end

  def convert_array(value)
    value.split("|")
  end
end
