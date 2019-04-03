require "csv"

class ManufacturerDbToCsv
  COLUMNS = [
    :id,
    :name,
    :description,
    :location,
    :verified,
    :ul,
    :ul_c,
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
    attr_names = COLUMNS.map(&:to_s)
    manufacturers.map do |manufacturer|
      manufacturer.attributes.slice(*attr_names).transform_values(&:to_s)
    end
  end

  def manufacturers
    Manufacturer.order(:name)
  end
end
