FactoryBot.define do
  factory :material do
    manufacturer
    function { "dielectric" }
    group { "FR4" }
  end
end
