FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "ใในใ #{n}" }
  end
end
