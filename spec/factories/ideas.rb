FactoryBot.define do
  factory :idea do
    category { FactoryBot.create(:category) }
    body { 'ใในใ' }
  end
end
