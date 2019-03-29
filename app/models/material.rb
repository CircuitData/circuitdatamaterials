class Material < ApplicationRecord
  belongs_to :manufacturer, optional: true
end
