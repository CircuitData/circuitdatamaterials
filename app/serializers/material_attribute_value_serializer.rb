class MaterialAttributeValueSerializer < ActiveModel::Serializer
  attributes :value, :value_type
  #belongs_to :material_attribute
end