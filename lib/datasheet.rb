class Datasheet
  def initialize(material)
    @material = material
  end

  def exist?
    material.manufacturer_name.present? && File.exist?(file_path)
  end

  def file_path
    Rails.root.join(
      "lib",
      "datasheets",
      clean(material.manufacturer_name),
      filename
    )
  end

  def contents
    File.open(file_path, "rb")
  end

  def filename
    @filename ||= "#{clean(material.name)}.pdf"
  end

  private

  attr_reader :material

  def clean(str)
    str.downcase.gsub(/\W+/, "_").gsub(/\s+/, "_")
  end
end
