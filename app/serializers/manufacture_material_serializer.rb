class ManufactureMaterialSerializer < ActiveModel::Serializer
  attributes :name, :function, :group, :flexible, :additional, :link, :remark, :ul_94, :accept_equivalent
  #belongs_to :manufacturer, optional: true
  #has_many :material_attributes, include_nested_associations: true

 # def manufacturer
 #   object.manufacturer do |manufacturer|
 #     ManufacturerSerializer.new(manufacturer, scope: scope, root: true, material: object)
 #   end
 # end

end