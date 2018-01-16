class MaterialAttributeSerializer < ActiveModel::Serializer
  attributes :name
  #belongs_to :material
  has_many :material_attribute_values
end