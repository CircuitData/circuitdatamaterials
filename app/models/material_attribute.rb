class MaterialAttribute < ApplicationRecord
  has_many :material_attribute_values
  belongs_to :material
end
