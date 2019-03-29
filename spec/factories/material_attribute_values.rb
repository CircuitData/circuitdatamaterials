FactoryBot.define do
  factory :material_attribute_value do
    value_type { "string" }
    value { "red" }
    material_attribute
  end
end
