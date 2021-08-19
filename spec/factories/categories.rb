FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "テスト #{n}" }
  end
end
