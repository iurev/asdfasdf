require 'rails_helper'

RSpec.describe "Comments", type: :request do
  describe "POST /create" do
    let!(:user) { create(:user, nickname: "ivan") }
    let!(:article) { create(:article, body: "yyyyyy uuuu asdfadsfasdfasdfa") }
    let(:comment_body) { "my first comment" }

    it "returns http success" do
      post "/comments", params: { body: comment_body, article_id: article.id, user_nickname: user.nickname }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(body)["body"]).to eq(comment_body)
    end
  end
end
