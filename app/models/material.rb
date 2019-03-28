class Material < ApplicationRecord
  belongs_to :manufacturer, optional: true
  belongs_to :function, optional: true
  belongs_to :group, optional: true
  has_many :material_attributes
end
