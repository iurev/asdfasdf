class ArticlesController < ApplicationController
  def index
    render json: Article.all.to_json
  end

  def show
    article = Article.find(params[:id])
    render json: article.to_json
  end
end
