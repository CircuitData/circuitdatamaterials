FactoryBot.define do
  factory :material do
    manufacturer
    function { "dielectric" }
    group { "FR4" }
    sequence(:name) { |n| "Cheese-#{n}" }
  end
end
