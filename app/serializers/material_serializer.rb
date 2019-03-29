class MaterialSerializer < ActiveModel::Serializer
  attributes :id, :name, :group, :mf_name, :attributes, :values

  def manufacturer
    if object.manufacturer
      ManuSerializer.new(object.manufacturer, scope: scope, root: true, material: object)
    end
  end
end
