FactoryBot.define do
  factory :idea do
    category { FactoryBot.create(:category) }
    body { 'テスト' }
  end
end
