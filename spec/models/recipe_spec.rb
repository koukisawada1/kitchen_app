require 'rails_helper'

RSpec.describe 'Recipeモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    before do
      @recipe = Recipe.new
    end

    context 'titleカラム' do
      it '空欄でないこと' do
        @recipe.title = ''
        expect(@recipe.valid?).to eq false;
      end
      it '30文字以下であること' do
        @recipe.title = Faker::Lorem.characters(number:31)
        expect(@recipe.valid?).to eq false;
      end
    end
    context 'bodyカラム' do
      it '空欄でないこと' do
        @recipe.body = ''
        expect(@recipe.valid?).to eq false;
      end
      it '200文字以下であること' do
        @recipe.body = Faker::Lorem.characters(number:201)
        expect(@recipe.valid?).to eq false;
      end
    end
    context 'priceカラム' do
      it '空欄でないこと' do
        @recipe.price = ''
        expect(@recipe.valid?).to eq false;
      end
    end
    context 'quantityカラム' do
      it '空欄でないこと' do
        @recipe.quantity = ''
        expect(@recipe.valid?).to eq false;
      end
    end
    context 'materialカラム' do
      it '空欄でないこと' do
        @recipe.material = ''
        expect(@recipe.valid?).to eq false;
      end
    end

    context 'makeカラム' do
      it '空欄でないこと' do
        @recipe.make = ''
        expect(@recipe.valid?).to eq false;
      end
    end
    context 'genre_idカラム' do
      it '空欄でないこと' do
        @recipe.genre_id = ''
        expect(@recipe.valid?).to eq false;
      end
    end
    context 'type_idカラム' do
      it '空欄でないこと' do
        @recipe.type_id = ''
        expect(@recipe.valid?).to eq false;
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Recipe.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Genreモデルとの関係' do
      it 'N:1となっている' do
        expect(Recipe.reflect_on_association(:genre).macro).to eq :belongs_to
      end
    end
    context 'Typeモデルとの関係' do
      it 'N:1となっている' do
        expect(Recipe.reflect_on_association(:type).macro).to eq :belongs_to
      end
    end
    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Recipe.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
    context 'Likeモデルとの関係' do
      it '1:Nとなっている' do
        expect(Recipe.reflect_on_association(:likes).macro).to eq :has_many
      end
    end
    context 'RecipeTagモデルとの関係' do
      it '1:Nとなっている' do
        expect(Recipe.reflect_on_association(:recipe_tags).macro).to eq :has_many
      end
    end
    context 'tagモデルとの関係' do
      it '1:Nとなっている' do
        expect(Recipe.reflect_on_association(:tags).macro).to eq :has_many
      end
    end
  end
end