require 'rails_helper'

RSpec.describe 'Recipeモデルのテスト', type: :model do
  	describe 'バリデーションのテスト' do
	    before do
	      	@user = User.new
	    end
	    context 'nameカラム' do
	      	it '空欄でないこと' do
	        	@user.name = ''
	        	expect(@user.valid?).to eq false;
	      	end
	      	it '20文字以下であること' do
		        @user.name = Faker::Lorem.characters(number:21)
		        expect(@user.valid?).to eq false;
	      	end
		    it '1文字以上であること' do
		        @user.name = Faker::Lorem.characters(number:1)
		        expect(@user.valid?).to eq false;
	      	end
	    end
	    context 'introductionカラム' do
	      	it '空欄でないこと' do
	        	@user.introduction = ''
	        	expect(@user.valid?).to eq false;
	      	end
	      	it '200文字以下であること' do
		        @user.introduction = Faker::Lorem.characters(number:201)
		        expect(@user.valid?).to eq false;
	      	end
	    end
	    context 'emailカラム' do
	      	it '空欄でないこと' do
	        	@user.email = ''
	        	expect(@user.valid?).to eq false;
	      	end
	    end
	end
	describe 'アソシエーションのテスト' do
    	context 'Recipeモデルとの関係' do
      		it '1:Nとなっている' do
        		expect(User.reflect_on_association(:recipes).macro).to eq :has_many
      		end
    	end
    	context 'Likeモデルとの関係' do
      		it '1:Nとなっている' do
        		expect(User.reflect_on_association(:likes).macro).to eq :has_many
      		end
    	end
    	context 'Commentモデルとの関係' do
      		it '1:Nとなっている' do
        		expect(User.reflect_on_association(:comments).macro).to eq :has_many
      		end
    	end
    end
end
