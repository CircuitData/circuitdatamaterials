require "csv"

class ManufacturerCsvToDb
  BOOL_MAP = {
    "true" => true,
    "false" => false,
  }

  def initialize(csv_string)
    @csv = CSV.parse(csv_string, headers: true)
  end

  def manufacturers
    @manufacturers ||= convert_rows
  end

  def load_into_db
    Manufacturer.delete_all

    manufacturers.each do |attrs|
      begin
        Manufacturer.upsert!(attrs)
      rescue => e
        Rails.logger.error("Manufacturer #{attrs[:id]} is invalid: #{e.message}")
        raise e
      end
    end
  end

  private

  attr_reader :csv

  def convert_rows
    csv.map do |row|
      h = row.to_h
      h["verified"] = BOOL_MAP[h["verified"]]
      h
    end
  end
end
