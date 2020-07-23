require 'rails_helper'

RSpec.describe "Recipes", type: :request do
      @recipe = Recipe.new
      @recipe.id = 1
	describe 'レシピ投稿ページ' do
    	context "レシピ投稿ページが正しく表示される" do
      		before do
        		get new_recipe_path
      		end
      		it 'リクエストは200 OKとなること' do
        		expect(response.status).to eq 200
        	end
        	it 'タイトルが正しく表示されていること' do
		        expect(response.body).to include("レシピを投稿する")
		    end
    	end
  	end
  	describe '編集のテスト' do
  		context '自分の投稿の編集画面への遷移' do
  	 	 	it '遷移できる' do
		  		visit edit_recipe_path(@recipe)
		  		expect(current_path).to eq('/books/' + book.id.to_s + '/edit')
		  	end
	  	end
		# context '他人の投稿の編集画面への遷移' do
		#  	it '遷移できない' do
		# 	    visit edit_book_path(book2)
		# 	    expect(current_path).to eq('/books')
		# 	end
		# end
	end
  	# describe 'レシピ編集ページ' do
   #  	context "レシピ編集ページが正しく表示される" do
   #    		before do
   #      		get edit_recipe_path(@recipe.id)
   #    		end
   #    		it 'リクエストは200 OKとなること' do
   #      		expect(response.status).to eq 200
   #      	end
   #      	it 'タイトルが正しく表示されていること' do
		 #        expect(response.body).to include("レシピを編集する")
		 #    end
   #  	end
  	# end
  	# describe 'レシピ投稿確認ページ' do
   #  	context "レシピ投稿確認ページが正しく表示される" do
   #    		before do
   #      		get confirm_recipe_path(@recipe)
   #    		end
   #    		it 'リクエストは200 OKとなること' do
   #      		expect(response.status).to eq 200
   #      	end
   #      	it 'タイトルが正しく表示されていること' do
		 #        expect(response.body).to include("レシピ確認")
		 #    end
   #  	end
  	# end
  	# describe 'レシピ一覧ページ' do
   #  	context "レシピ一覧ページが正しく表示される" do
   #    		before do
   #      		get recipes_path
   #    		end
   #    		it 'リクエストは200 OKとなること' do
   #      		expect(response.status).to eq 200
   #      	end
   #      	it 'タイトルが正しく表示されていること' do
		 #        expect(response.body).to include("レシピ")
		 #    end
   #  	end
  	# end
  	# describe 'レシピ詳細ページ' do
   #  	context "レシピ詳細ページが正しく表示される" do
   #    		before do
   #      		get recipe_path(@recipe)
   #    		end
   #    		it 'リクエストは200 OKとなること' do
   #      		expect(response.status).to eq 200
   #      	end
   #  	end
  	# end
end

