class Material < ApplicationRecord
  belongs_to :manufacturer, optional: true
  has_many :material_attributes
end