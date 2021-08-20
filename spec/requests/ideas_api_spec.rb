require 'rails_helper'
describe 'Ideas API', type: :request do
  let(:category) { FactoryBot.create(:category) } 

  describe "get idea" do
    context "blank category_name" do
      it "responds successfully" do
        get ideas_path, params: { category_name: nil }
        expect(response).to  have_http_status(200)
      end
    end

    context "presence params category_name" do
      it "adds a idea" do
        FactoryBot.create(:idea, body: 'サンプル1', category_id: category.id)
        FactoryBot.create(:idea, body: 'サンプル2', category_id: category.id)
        get ideas_path, params: { category_name: category.name }
        data = JSON.parse(response.body)["data"]
        expect(data.size).to eq(2)
        expect(response).to have_http_status(200)
      end

      it "does not add idea" do
        FactoryBot.create(:idea)
        get ideas_path, params: { category_name: '登録されていないカテゴリ名' }
        expect(response).to have_http_status(404)
      end
    end
  end
  
  describe "create a idea" do
    context "presence params category_name" do
      it 'adds a idea' do
        post ideas_path, params: { body: 'カテゴリー既にある', category_name: category.name }
        expect(response).to have_http_status(201)
        expect(Idea.all.count).to eq(1)
      end

      it "adds idea with category" do
        expect{
          post ideas_path, params: { body: 'カテゴリも一緒に作られる', category_name: 'カテゴリー' }
        }.to change{ Category.all.size }.from(0).to(1)
        expect(response).to have_http_status(201)
        expect(Idea.find_by(body: 'カテゴリも一緒に作られる')).to be_present
      end

      it 'is invalid without a body' do
        post ideas_path, params: { body: nil, category_name: 'カテゴリー' }
        expect(response).to have_http_status(422)
      end
    end

    context "blank category_name" do
      it 'is invalid without a category_name ' do
        post ideas_path, params: { body: 'カテゴリなし', category_name: nil }
        expect(response).to have_http_status(422)
      end
    end
  end
end