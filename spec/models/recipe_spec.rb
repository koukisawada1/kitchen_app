require 'rails_helper'

RSpec.describe 'Recipeモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    # let(:user) { create(:user) }
    # let!(:recipe) { build(:recipe, user_id: user.id) }

    context 'titleカラム' do
      it '空欄でないこと' do
        recipe.title = ''
        expect(recipe.valid?).to eq false;
      end
      it '30文字以下であること' do
        recipe.title = Faker::Lorem.characters(number:31)
        expect(recipe.valid?).to eq false;
      end
    end
    context 'bodyカラム' do
      it '空欄でないこと' do
        recipe.body = ''
        expect(recipe.valid?).to eq false;
      end
      it '200文字以下であること' do
        recipe.body = Faker::Lorem.characters(number:201)
        expect(recipe.valid?).to eq false;
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Recipe.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end