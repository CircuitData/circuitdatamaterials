class MaterialComparator
  def initialize(material_ids)
    @uuids = material_ids
  end

  def compare
    @uuids.map{|uuid| Material.find_by(id: uuid)}
  end
end