require 'rails_helper'

RSpec.describe "Recipes", type: :request do
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
  	describe 'レシピ一覧ページ' do
    	context "レシピ一覧ページが正しく表示される" do
      		before do
        		get recipes_path
      		end
      		it 'リクエストは200 OKとなること' do
        		expect(response.status).to eq 200
        	end
        	it 'タイトルが正しく表示されていること' do
		        expect(response.body).to include("レシピ")
		    end
    	end
  	end
end

