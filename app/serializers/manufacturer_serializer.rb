class ManufacturerSerializer < ActiveModel::Serializer
  attributes :name, :verified, :source, :source_id, :description, :location, :ul, :ul_c, :materials
  #has_many :materials, include: :name
  def materials
    object.materials.map do |material|
      ManufactureMaterialSerializer.new(material, scope: scope, root: true, manufacturer: object)
    end
  end
end