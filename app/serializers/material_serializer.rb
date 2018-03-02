class MaterialSerializer < ActiveModel::Serializer
  attributes :circuitdata_version, :name, :verified, :id, :source, :source_id, :function, :group, :flexible, :additional, :link, :remark, :ul_94, :accept_equivalent, :manufacturer
  #belongs_to :manufacturer, optional: true
  has_many :material_attributes, include_nested_associations: true

  def manufacturer
    #object.manufacturer do |manufacturer|
    if object.manufacturer
     ManuSerializer.new(object.manufacturer, scope: scope, root: true, material: object)
    end
  end

end