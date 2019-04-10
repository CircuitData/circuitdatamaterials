FactoryBot.define do
  factory :manufacturer do
    sequence(:name) { |n| "Big Pizza-#{n}" }
  end
end
