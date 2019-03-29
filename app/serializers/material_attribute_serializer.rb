class MaterialAttributeSerializer < ActiveModel::Serializer
  attributes :name
  has_many :material_attribute_values
end
