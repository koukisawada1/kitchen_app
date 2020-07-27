require 'rails_helper'

RSpec.describe "BelongsTos", type: :request do

  describe "GET /:user" do
    it "returns http success" do
      get "/belongs_to/:user"
      expect(response).to have_http_status(:success)
    end
  end

end
