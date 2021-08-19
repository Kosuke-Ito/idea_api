require 'rails_helper'

RSpec.describe Category, type: :model do

  it "is invalid without name" do
    category = FactoryBot.build(:category, name: nil)
    category.valid?
    expect(category.errors[:name]).to include("can't be blank")
  end

  it "is invalid with a duplicate name" do
    FactoryBot.create(:category, name: "イベント")
    category = FactoryBot.build(:category, name: "イベント")
    category.valid?
    expect(category.errors[:name]).to include("has already been taken")
  end

end