require 'rails_helper'

RSpec.describe 'Recipeモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    before do
      @comment = Comment.new
    end

    context 'commentカラム' do
      it '空欄でないこと' do
        @comment.comment = ''
        expect(@comment.valid?).to eq false;
      end
      it '200文字以下であること' do
        @comment.comment = Faker::Lorem.characters(number:201)
        expect(@comment.valid?).to eq false;
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Recipeモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:recipe).macro).to eq :belongs_to
      end
    end
  end
end