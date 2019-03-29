class MaterialSerializer < ActiveModel::Serializer
  attributes(
    :circuitdata_material_db_id,
    :manufacturer,
    :name,
    :remark,
    :ul94,
    :link,
    :flexible,
    :accept_equivalent,
  )

  attribute :attrs, key: :attributes

  def circuitdata_material_db_id
    object.id
  end

  def manufacturer
    object.manufacturer&.name
  end

  def ul94
    object.ul_94
  end

  def attrs
    MaterialAttributeSerializer.new(object)
  end
end
