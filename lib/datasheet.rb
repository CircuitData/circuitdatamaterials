class Datasheet
  def initialize(material)
    @material = material
  end

  def exist?
    File.exist?(file_path)
  end

  def file_path
    Rails.root.join(
      "lib",
      "datasheets",
      clean(material.manufacturer_name),
      "#{clean(material.name)}.pdf"
    )
  end

  private

  attr_reader :material

  def clean(str)
    str.downcase.gsub(/\W+/, "_").gsub(/\s+/, "_")
  end
end
