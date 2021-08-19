require 'rails_helper'

RSpec.describe Idea, type: :model do
  let(:category) { FactoryBot.create(:category) }
  
  # bodyがなければ無効
  it "is invalid without body" do
    idea = Idea.new(
      category_id: category.id,
      body: nil
    )
    idea.valid?
    expect(idea.errors[:body]).to include("can't be blank")
  end

  # category_idがなければ無効
  it "is invalid without category_id" do
    idea = Idea.new(
      category_id: nil,
      body: '文章'
    )
    idea.valid?
    expect(idea.errors[:category_id]).to include("can't be blank")
  end

end
