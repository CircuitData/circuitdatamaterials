class MaterialSerializer < ApplicationSerializer
  attributes(
    :version,
    :circuitdata_material_db_id,
    :function,
    :group,
    :manufacturer,
    :name,
    :flexible,
    :link,
    :remark,
    :additional,
    :verified,
    :accept_equivalent,
    :ul94,
  )

  attribute :attrs, key: :attributes

  def circuitdata_material_db_id
    object.id
  end

  def manufacturer
    object.manufacturer_name
  end

  def ul94
    object.ul_94
  end

  def attrs
    MaterialAttributeSerializer.new(object)
  end

  def version
    1.0
  end
end
