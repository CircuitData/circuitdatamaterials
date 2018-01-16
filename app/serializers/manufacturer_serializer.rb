class ManufacturerSerializer < ActiveModel::Serializer
  attributes :name, :verified, :description, :location, :materials
  #has_many :materials, include: :name

  def materials
    object.materials.map do |material|
      ManufactureMaterialSerializer.new(material, scope: scope, root: true, manufacturer: object)
    end
  end

end